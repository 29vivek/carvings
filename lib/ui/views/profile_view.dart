import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/viewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      onModelReady: (model) => model.getUser(),
      builder: (context, model, child) => PlatformScaffold(
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NoteText(model.user.id),
              NoteText(model.user.email),
              NoteText(model.user.name),
              NoteText(model.user.number),
              NoteText(model.user.role),
              BusyButton(
                busy: model.busy,
                title: 'Logout',
                onPressed: () {
                  model.logout();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}