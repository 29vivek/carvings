import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/food_card.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/viewmodels/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class SearchView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SearchViewModel>.withConsumer(
      viewModel: SearchViewModel(),
      onModelReady: (model) => model.findRole(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async => model.getFoodItems(_searchController.text),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            onPanDown: (_) {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: defaultPadding(context),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Search', style: headerTextStyle),
                  verticalSpaceMedium,
                  InputField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    placeholder: 'Search...',
                    enterPressed: () {
                      model.getFoodItems(_searchController.text.trim());
                    },
                  ),
                  verticalSpaceMedium,
                  Expanded(
                    child: model.searchedItems != null
                    ? model.searchedItems.length > 0
                    ? GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: smartAspectRatio(context),
                        mainAxisSpacing: 25, // verticalSpaceMedium
                        crossAxisSpacing: 25,
                        children: List.generate(model.searchedItems.length, (index) => index)
                          .map((foodIndex) => FoodCard(
                            food: model.searchedItems[foodIndex], 
                            onPressed: () {
                              model.addToCart(model.searchedItems[foodIndex]);
                            },
                            onLongPressed: () {
                              model.role == 'Admin' 
                              ? model.navigateToEditFood(model.searchedItems[foodIndex])
                              : model.addToFavourites(model.searchedItems[foodIndex]);
                            }
                          )).toList()
                      )
                    : NoteText('Whoops. We didn\'t find anything.')
                    : NoteText('Enter a keyword. Go on, enter it!')
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
