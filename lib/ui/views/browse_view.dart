import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/flat_card.dart';
import 'package:carvings/ui/widgets/loading_card.dart';
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
        body: Padding(
          padding: defaultPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Favourites', style: headerTextStyle,),
              verticalSpaceMedium,
              Text('Duh. Your favourites is empty!', style: infoTextStyle, textAlign: TextAlign.center,),
              verticalSpaceMedium,
              model.canteens != null
              ? Expanded(
                child: ListView.builder(
                    itemCount: model.canteens.length,
                    itemBuilder: (context, int id) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatCard(
                          title: model.canteens[id].name,
                          description: model.canteens[id].description,
                          onPressed: () => model.navigateToCanteen(id + 1), // nice little hack.
                        ),
                        verticalSpaceMedium,
                      ],
                    )
                  )
                )
              : LoadingCard()
            ],
          ),
        ),
      ),
    );
  }
}