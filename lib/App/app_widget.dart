import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/App/Navigation/nav_widget.dart';
import 'package:flutter_weather/DI/injectable.dart';
import 'package:flutter_weather/Pages/Splash/splash_bloc.dart';
import 'package:flutter_weather/Pages/Splash/splash_event.dart';
import 'package:flutter_weather/Pages/Weather/weather_event.dart';

/// Here I want to have an separate AppWidget which should call NavWidget
/// to handle any error messages (or any general events) on App level. I've
/// created an AppEvent/AppState... and ended up with dead loop... that's why
/// I decided to create error handling mixin (ErrorHandlingMixin) which provides
/// method to queue an snack bar to show errors
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AppInjection.forecastBloc..add(ForecastRequest())),
        BlocProvider(create: (_) => SplashBloc()..add(StartTimer())),
      ],
      child: NavWidget(),
    );
  }
}
