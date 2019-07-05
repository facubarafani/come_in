import 'package:flutter/material.dart';

class ComeInProvider extends InheritedWidget {


  ComeInProvider({
    Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ComeInProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ComeInProvider);
}