import 'package:flutter/widgets.dart';
import 'package:unihack/bloc/authentication/authentication_bloc.dart';

class IndextBloc {
  final AuthenticationBloc authenticationBloc;

  IndextBloc({
    required this.authenticationBloc,
  });
}

class IndextBlocProvider extends InheritedWidget{
  final Widget child;
  final IndextBlocProviderData data;

  const IndextBlocProvider({
    Key? key,
    required this.child,
    required this.data,
  })  : super(key:key, child: child);

  static IndextBlocProviderData of(BuildContext context){
    final provider = context.dependOnInheritedWidgetOfExactType<IndextBlocProvider>();
    if(provider == null){
      throw Exception("No IndextBlocProvider found in context");
    }
    return provider.data;
  }
  @override
  bool updateShouldNotify(IndextBlocProvider oldWidget){
    return data != oldWidget.data;
  }
}

class IndextBlocProviderData{
  final IndextBloc indextBloc;

  const IndextBlocProviderData(this.indextBloc);
}