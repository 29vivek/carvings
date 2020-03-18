import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/expansion_list.dart';
import 'package:carvings/ui/widgets/form_list.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/ui/widgets/sheet_content.dart';
import 'package:carvings/viewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class ProfileView extends StatelessWidget {

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      onModelReady: (model) => model.getUser(),
      builder: (context, model, child) => PlatformScaffold(
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Profile',
                style: TextStyle(fontSize: 38),
              ),
              NoteText('${model.user.email}'),
              NoteText('${model.user.name}'),
              NoteText('${model.user.number}'),
              NoteText('${model.user.role}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  BusyButton(
                    title: 'Edit', 
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return SheetContent(
                          child: FormList(
                            title: 'Your Details',
                            nonEditables: [model.user.email, model.user.role],
                            editables: [
                              InputField(
                                controller: nameController,
                                placeholder: model.user.name,
                                textInputType: TextInputType.text,
                                onChanged: (String s) => model.couldBeSaved(s),
                              ),
                              InputField(
                                controller: numberController,
                                placeholder: model.user.number,
                                textInputType: TextInputType.number,
                                additionalNote: 'Enter a 10 digit phone number',
                                onChanged: (String s) => model.couldBeSaved(s),
                              )
                            ],
                            button: BusyButton(
                              title: 'Save',
                              busy: model.busy,
                              onPressed: () => model.saveDetails(nameController.text, numberController.text),
                              enabled: model.canBeSaved,
                            ),  
                          )
                        );
                      },
                    ),
                  ),
                  horizontalSpaceSmall,
                  BusyButton(title: 'Logout', onPressed: () => model.logout())
                ],
              ),
              verticalSpaceLarge,
              Text('History',
                style: TextStyle(fontSize: 38)
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