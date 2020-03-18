import 'package:flutter/widgets.dart';

class SheetContent extends StatelessWidget {
  
  final Widget child;

  SheetContent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: child,
        ),
      ),
    );
  }
}