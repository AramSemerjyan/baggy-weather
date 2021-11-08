import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/App/Navigation/nav_bloc.dart';
import 'package:flutter_weather/App/Navigation/nav_event.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';
import 'package:flutter_weather/Pages/Splash/splash_bloc.dart';
import 'package:flutter_weather/Pages/Splash/splash_state.dart';

/// I'm not sure is this a Splash Screen you want me to create
/// But here it is... with original logo from me!!
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackgroundColor,
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (c, state) {
          if (state is TimersOut) {
            BlocProvider.of<NavBloc>(context).add(GoToHomePageEvent());
          }

          return Center(
            child: Image.asset('assets/logo.png'),
          );
        },
      ),
    );
  }
}
