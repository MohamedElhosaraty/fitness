import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  Logger logger = Logger();

  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.f('${bloc.runtimeType} created');
  }

  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.w('${bloc.runtimeType} $change');
  }

  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.w('${bloc.runtimeType} $transition');
  }


  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.e('${bloc.runtimeType} closed');
  }
}
