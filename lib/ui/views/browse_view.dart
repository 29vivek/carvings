import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/flat_card.dart';
import 'package:carvings/viewmodels/browse_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';

class BrowseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BrowseViewModel>.withConsumer(
      viewModel: BrowseViewModel(), 
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: defaultPadding(context),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Favourites', style: headerTextStyle,),
              verticalSpaceMedium,
              Text('Duh. Your favourites is empty!', style: infoTextStyle, textAlign: TextAlign.center,),
              spacedDivider,
              FlatCard(
                title: 'Main Canteen',
                description: 'This is where the real food cooks, and there is a lot of rush especially for idlis and vadas.',
                onPressed: () {},
              ),
              verticalSpaceMedium,
              FlatCard(
                title: 'Mini Canteen',
                description: 'This is the mini canteen to fulfill cravings that occur during the short break. Be on your toes to get the samosas. They come just once a while, also famous for its bun samosas. Don\'t ask me how.',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}