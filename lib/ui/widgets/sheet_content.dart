import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class SheetContent extends StatelessWidget {
  
  final Widget child;

  SheetContent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          // works without this
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: defaultPadding(context),
            child: child,
          ),
        ),
      ),
    );
  }
}