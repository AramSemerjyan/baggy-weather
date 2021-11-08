import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/App/Navigation/nav_event.dart';
import 'package:flutter_weather/Pages/Weather/weather_page.dart';

class NavBloc extends Bloc<NavEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavBloc({required this.navigatorKey}) : super(null);

  @override
  Stream<dynamic> mapEventToState(NavEvent event) async* {
    if (event is GoToHomePageEvent) {
      navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (_) => const WeatherPage()));
    }
  }
}
