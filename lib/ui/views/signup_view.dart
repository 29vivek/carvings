import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/viewmodels/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class SignUpView extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        body: LayoutBuilder(
          builder: (context, viewPortConstraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewPortConstraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 38),
                    ),
                    verticalSpaceLarge,
                    InputField(
                      controller: emailController, 
                      placeholder: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      controller: nameController,
                      placeholder: 'Name',
                      textInputType: TextInputType.text,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      controller: numberController,
                      placeholder: 'Number',
                      textInputType: TextInputType.number,
                      additionalNote: 'Enter a 10 digit phone number.',
                    ),
                    verticalSpaceSmall,
                    InputField(
                      controller: passwordController,
                      placeholder: 'Password',
                      password: true,
                      additionalNote: 'Password must be atleast 6 characters long.',
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        BusyButton(
                          title: 'Sign Up',
                          busy: model.busy,
                          onPressed: () {
                            // Perform sign up here
                            model.signUp(
                              email: emailController.text, name: nameController.text,
                              number: numberController.text, password: passwordController.text,
                            );
                          },
                        ),
                      ],
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}