import 'package:carvings/viewmodels/startup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';


class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) => model.handleStartUpLogic());
      },
      builder: (context, model , child) {
        return PlatformScaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  child: Image.asset('images/rvce_logo.png'),
                  width: 300.0,
                  height: 150.0,
                ),
                verticalSpaceMedium,
                CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation(Colors.grey[800]),
                ),
              ],
            ),
          ),
        );
      },
      
    );
  }

}