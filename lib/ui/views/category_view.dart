import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/expansion_list.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/viewmodels/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CategoryView extends StatelessWidget {

  final bool isAdd;
  final controller = TextEditingController();

  CategoryView({Key key, this.isAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CategoryViewModel>.withConsumer(
      viewModel: CategoryViewModel(), 
      onModelReady: (model) => model.getCategories(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: defaultPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Categories', style: headerTextStyle),
              verticalSpaceMedium,
              if(model.categories != null)
                Column(
                  children: <Widget>[
                    ExpansionList(
                      items: model.categories.keys.toList(),
                      title: model.selectedCanteen,
                      onItemSelected: (canteen) => model.selectCanteen(canteen),
                    ),
                    verticalSpaceSmall,
                    if(!isAdd)
                      ExpansionList(
                        items: model.selectedCanteen == 'Select a Canteen' ? ['Select a Category'] : model.categories[model.selectedCanteen].map((category) => category.categoryName).toList(),
                        title: model.selectedCategory,
                        onItemSelected: (category) => model.selectCategory(category),
                      )
                    else 
                      InputField(controller: controller, placeholder: 'Enter a category name', textInputType: TextInputType.text, additionalNote: 'Enter a name which is not already present.',)
                  ],
                ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  BusyButton(
                    busy: model.busy,
                    title: isAdd ? 'Add Category' : 'Remove Category', 
                    onPressed: () => model.performAction(controller.text, isAdd),                     
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}