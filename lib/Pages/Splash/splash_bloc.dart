import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/Pages/Splash/splash_event.dart';
import 'package:flutter_weather/Pages/Splash/splash_state.dart';

class SplashBloc extends Bloc<dynamic, SplashState> {
  SplashBloc() : super(TimersOn());

  Timer? _timer;

  @override
  Stream<SplashState> mapEventToState(event) async* {
    if (event is StartTimer) {
      _timer = Timer.periodic(Duration(seconds: event.duration), (timer) {
        _timer?.cancel();
        _timer = null;
        add(StopTimer());
      });
    }

    if (event is StopTimer) {
      yield TimersOut();
    }
  }
}
