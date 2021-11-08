import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/App/Navigation/nav_bloc.dart';
import 'package:flutter_weather/App/localization_widget.dart';
import 'package:flutter_weather/Pages/Splash/spash_page.dart';

class NavWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  NavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavBloc>(
      create: (_) => NavBloc(navigatorKey: _navigatorKey),
      child: LocalizationWidget(
        navKey: _navigatorKey,
        home: const SplashPage(),
      ),
    );
  }
}
