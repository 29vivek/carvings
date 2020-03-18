import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/ui/widgets/text_link.dart';
import 'package:carvings/viewmodels/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class LoginView extends StatelessWidget {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Carvings',
                  style: TextStyle(fontSize: 38),
                ),
                verticalSpaceLarge,
                InputField(
                  placeholder: 'Email',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BusyButton(
                      title: 'Login',
                      busy: model.busy,
                      onPressed: () {
                        model.login(email: emailController.text, password: passwordController.text);
                      },
                    )
                  ],
                ),
                verticalSpaceMedium,
                TextLink(
                  'Create an Account if you\'re new.',
                  onPressed: () {
                    // TODO: Handle navigation
                    model.navigateToSignUp();
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}