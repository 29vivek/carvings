import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/widgets/food_card.dart';
import 'package:carvings/ui/widgets/loading_card.dart';
import 'package:carvings/viewmodels/canteen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:sticky_headers/sticky_headers.dart';


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
        body: RefreshIndicator(
          onRefresh: () async => model.getFoodItems(canteenId),
          child: Padding(
            padding: defaultPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                model.canteen != null
                ? Text(model.canteen.name, style: headerTextStyle)
                : LoadingCard(),
                Expanded(
                  child: ListView(
                    children: model.food != null
                    ? List.generate(model.food.keys.length, (i) => i).map((category) => StickyHeaderBuilder(
                        overlapHeaders: false,
                        builder: (context, stuckAmount) {
                          stuckAmount = stuckAmount.clamp(0.0, 1.0);
                          return Container(
                            // the 50 height acts kinda like 2 x verticalSpaceMedium so nice little hack #3 I guess
                            height: 100.0 - (50 * (1 - stuckAmount)),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(
                              model.food.keys.elementAt(category),                 
                              style: subHeaderTextStyle.copyWith(color: Color.lerp(Colors.black87, Theme.of(context).primaryColor, stuckAmount)),
                            ),
                          );
                        },
                        content: Column(
                          children: <Widget>[
                            GridView.count(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: smartAspectRatio(context),
                              mainAxisSpacing: 25, // verticalSpaceMedium
                              crossAxisSpacing: 25,
                              children: List.generate(model.food.values.elementAt(category).length, (index) => index)
                                .map((foodIndex) => FoodCard(
                                  food: model.food.values.elementAt(category)[foodIndex], 
                                  onPressed: () {
                                    model.addToCart(model.food.values.elementAt(category)[foodIndex]);
                                  },
                                  onLongPressed: () {
                                    model.addToFavourites(model.food.values.elementAt(category)[foodIndex]);
                                  }
                                )).toList()
                            ),
                            topSpacedDivider,
                          ],
                        ),
                        ),
                      ).toList()
                    : List.generate(3, (i) => i).map((i) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          verticalSpaceMedium,
                          LoadingCard(),
                        ]))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}