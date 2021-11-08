abstract class SplashEvent {}

class StartTimer implements SplashEvent {
  final int duration;

  StartTimer({this.duration = 3});
}

class StopTimer implements SplashEvent {}
