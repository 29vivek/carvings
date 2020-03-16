import 'package:flutter/material.dart';

class LazyIndexedStack extends StatefulWidget {
  final AlignmentGeometry alignment;
  final TextDirection textDirection;
  final StackFit sizing;

  final int index;
  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final bool reuse;

  const LazyIndexedStack({
    Key key, 
    this.alignment = AlignmentDirectional.topStart, 
    this.textDirection, 
    this.sizing = StackFit.loose, 
    this.index, 
    this.itemCount = 0, 
    @required this.itemBuilder, 
    this.reuse = true,
  }) : super(key: key);

  @override
  _LazyIndexedStackState createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  
  List<Widget> _children;
  List<bool> _loaded;

  @override
  void initState() { 
    
    super.initState();

    _children = [];
    _loaded = [];
    for(int i=0; i<widget.itemCount; i++) {
      if(i == widget.index) {
        _children.add(widget.itemBuilder(context, i));
        _loaded.add(true);
      } else {
        _children.add(Container());
        _loaded.add(false);
      }
    }

  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    
    super.didUpdateWidget(oldWidget);

    for(int i=0; i<widget.itemCount; i++) {
      if(i == widget.index) {
        if(!_loaded[i]) {
          _children[i] = widget.itemBuilder(context, i);
          _loaded[i] = true;
        } else {
          if(widget.reuse)
            return;
          _children[i] = widget.itemBuilder(context, i);
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }
}