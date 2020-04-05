import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/expansion_list.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/viewmodels/modify_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';

class ModifyView<T> extends StatelessWidget {

  final T item;
  // the funda here is
  // item is null? Add Food
  // item is Canteen? Update Canteen
  // item is Food? Update Food

  ModifyView({Key key, this.item}) : super(key: key);

  final _controllerOne = TextEditingController();
  final _controllerTwo = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ModifyViewModel>.withConsumer(
      viewModel: ModifyViewModel(),
      onModelReady: (model) => model.getCanteens(item is Food ? item : null),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: defaultPadding(context),
            child: ListView(
              children: [
                Text(item != null ? 'Edit' : 'Add', style: headerTextStyle,),
                verticalSpaceMedium,
                if(item is Canteen)
                  InputField(controller: _controllerOne, placeholder: (item as Canteen).name),
                if(item is Food)
                  InputField(controller: _controllerOne, placeholder: (item as Food).name),
                if(item == null)
                  InputField(controller: _controllerOne, placeholder: 'Name'),
                verticalSpaceSmall,
                if(item is Canteen)
                  InputField(controller: _controllerTwo, textInputType: TextInputType.text, placeholder: (item as Canteen).description),
                if(item is Food)
                  InputField(controller: _controllerTwo, textInputType: TextInputType.number, placeholder: (item as Food).price.toString()),
                if(item == null)
                  InputField(controller: _controllerTwo, textInputType: TextInputType.number, placeholder: 'Price'),
                if(item is Food || item == null)
                  if(model.categories != null)
                    Column(
                      children: <Widget>[
                        verticalSpaceSmall,
                        ExpansionList(
                          items: model.categories.keys.toList(),
                          title: model.selectedCanteen,
                          onItemSelected: (canteen) => model.selectCanteen(canteen),
                        ),
                        verticalSpaceSmall,
                        ExpansionList(
                          items: model.selectedCanteen == 'Select a Canteen' ? ['Select a Category'] : model.categories[model.selectedCanteen].map((category) => category.categoryName).toList(),
                          title: model.selectedCategory,
                          onItemSelected: (category) => model.selectCategory(category),
                        ),
                      ],
                    ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    BusyButton(
                      busy: model.busy,
                      title: item == null ? 'Add' : 'Update', 
                      onPressed: item == null 
                          ? () => model.modifyFood(_controllerOne.text, _controllerTwo.text, 0)
                          : () => item is Food ? model.modifyFood(_controllerOne.text, _controllerTwo.text, (item as Food).id) : model.updateCanteenInfo(_controllerOne.text, _controllerTwo.text, (item as Canteen).id),                         
                    ),
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