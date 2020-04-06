import 'package:carvings/constants/route_names.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/flat_card.dart';
import 'package:carvings/ui/widgets/food_card.dart';
import 'package:carvings/ui/widgets/loading_card.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/ui/widgets/text_link.dart';
import 'package:carvings/viewmodels/browse_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BrowseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BrowseViewModel>.withConsumer(
      viewModel: BrowseViewModel(), 
      onModelReady: (model) => model.getCanteens(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async => model.role == 'User' ? model.getFavourites() : model.getCanteens(),
          child: Padding(
            padding: defaultPadding(context),
            child: ListView(
              children: <Widget>[
                Text(model.role == 'User' ? 'Favourites' : 'Home', style: headerTextStyle,),
                verticalSpaceMedium,
                model.favourites != null
                ? model.favourites.length != 0
                ? GridView.count(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: smartAspectRatio(context),
                    mainAxisSpacing: 25, // verticalSpaceMedium
                    crossAxisSpacing: 25,
                    children: List.generate(model.favourites.length, (index) => index)
                      .map((foodIndex) => FoodCard(
                        food: model.favourites[foodIndex], 
                        onPressed: () {
                          model.addToCart(model.favourites[foodIndex]);
                        },
                        onLongPressed: () {
                          model.removeFromFavourites(model.favourites[foodIndex]);
                        }
                      )).toList()
                  )
                : NoteText(model.role == 'User' ? 'Duh! Your favourites list is empty. Long press food items to add favourites.': 'Use your privilages wisely.') // another sneaky hack
                : LoadingCard(),
                topSpacedDivider,
                verticalSpaceMedium,
                model.canteens != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: model.canteens.length,
                    itemBuilder: (context, int id) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatCard(
                          title: model.canteens[id].name,
                          description: model.canteens[id].description,
                          onPressed: () => model.navigateToCanteen(id),
                          onLongPressed: model.role == 'Admin' ? () => model.editCanteen(id) : null,
                        ),
                        verticalSpaceMedium,
                      ],
                    )
                  )
                : Column(
                  children: <Widget>[
                    LoadingCard(),
                    verticalSpaceMedium,
                  ],
                ),
                if(model.role == 'Admin')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      bottomSpacedDivider,
                      Text('Actions', style: subHeaderTextStyle,),
                      verticalSpaceMedium,
                      TextLink('Add Food', onPressed: () => model.navigateToAddFood(),),
                      verticalSpaceMedium,
                      TextLink('Add Food Category', onPressed: () => model.navigateToCategories(true),),
                      verticalSpaceMedium,
                      TextLink('Remove Food Category', onPressed: () => model.navigateToCategories(false),),
                      verticalSpaceMedium,
                      TextLink('Mark all as available', onPressed: () => model.toggleAvailability(true),),
                      verticalSpaceMedium,
                      TextLink('Mark all as unavailable', onPressed: () => model.toggleAvailability(false),),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}