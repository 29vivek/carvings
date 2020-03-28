import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/widgets/expansion_list.dart';
import 'package:carvings/ui/widgets/text_link.dart';
import 'package:carvings/viewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      onModelReady: (model) => model.getUser(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: defaultPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${model.user.role} Profile',
                style: headerTextStyle,
              ),
              verticalSpaceMedium,
              RichText(
                text: TextSpan(
                  style: subHeaderTextStyle,
                  children: [
                    TextSpan(text: 'Hi '),
                    TextSpan(text: model.user.name, style: subHeaderTextStyle.copyWith(fontStyle: FontStyle.italic)),
                    TextSpan(text: '! Your email is '),
                    TextSpan(text: model.user.email, style: subHeaderTextStyle.copyWith(fontStyle: FontStyle.italic)),
                    TextSpan(text: ' and your number is '),
                    TextSpan(text: model.user.number, style: subHeaderTextStyle.copyWith(fontStyle: FontStyle.italic)),
                    TextSpan(text: '.')
                  ],
                ),
              ),
              verticalSpaceMedium,
              TextLink(
                'Edit Details',
                onPressed: () => model.editDetails(),
              ),
              verticalSpaceMedium,
              TextLink(
                'Not ${model.user.name}? Logout',
                onPressed: () => model.logout(),
              ),
              verticalSpaceLarge,
              Text('History',
                style: headerTextStyle,
              ),
              verticalSpaceSmall,
              ExpansionList<String>(
                items: <String> [
                  'All',
                  'Today',
                  'Past Week',
                  'This Month',
                  'This Year',
                ],
                title: model.selectedFilter,
                onItemSelected: (filter) => model.setSelectedFilter(filter),
              ),
            ],
          ),
        )
      ),
    );
  }
}