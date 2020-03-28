import 'package:carvings/ui/widgets/food_card.dart';
import 'package:carvings/ui/widgets/loading_card.dart';
import 'package:carvings/viewmodels/canteen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class CanteenView extends StatelessWidget {

  final int canteenId;

  const CanteenView({Key key, this.canteenId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CanteenViewModel>.withConsumer(
      viewModel: CanteenViewModel(),
      onModelReady: (model) => model.getFoodItems(canteenId),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            model.food != null 
            ? SliverPadding(
              padding: defaultPadding(context),
              sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: tenthScreenWidth(context),
                    mainAxisSpacing: tenthScreenWidth(context),
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, foodId) => FoodCard(
                      model.food[foodId], 
                      () {
                        // show bottom sheet
                      }
                    ),
                    childCount: model.food.length,
                  )
                ),
            )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: defaultPadding(context),
                  child: Column(
                    children: <Widget>[
                      LoadingCard(),
                      verticalSpaceMedium,
                      LoadingCard()
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}