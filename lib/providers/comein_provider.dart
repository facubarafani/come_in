import 'package:flutter/widgets.dart';
import 'package:come_in/bloc/comein_bloc.dart';

class ComeInProvider extends InheritedWidget {
  final ComeInBloc comeInBloc;

  ComeInProvider({
    this.comeInBloc,
    Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ComeInProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ComeInProvider);
}
