import 'package:flutter/material.dart';
import 'global_state_manager.dart';

class LooView extends StatefulWidget {
  final Widget child;
  final Function? onInit;

  const LooView({
    super.key,
    required this.child,
    this.onInit,
  });

  @override
  GlobalStateRootState createState() => GlobalStateRootState();
}

class GlobalStateRootState extends State<LooView> {
  void forceUpdateUI() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Loo.instance.setForceUpdateCallback(forceUpdateUI);

    if (widget.onInit != null) {
      widget.onInit!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
