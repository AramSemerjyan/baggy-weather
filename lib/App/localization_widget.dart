import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_weather/Helper/Localization/localization_delegate.dart';

/// This whole localization part wasn't developed by my... well... it is...
/// but I use help from this article: https://medium.com/flutter-community/multi-language-support-in-flutter-a12de708f833
/// I finally know how to handle localization!! Yeeey... or no?
class LocalizationWidget extends StatefulWidget {
  final Widget home;
  final GlobalKey<NavigatorState> navKey;

  const LocalizationWidget({Key? key, required this.home, required this.navKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LocalizationWidgetState();
}

class _LocalizationWidgetState extends State<LocalizationWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navKey,
      builder: (context, child) {
        return MediaQuery(
          child: child ?? widget.home,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      debugShowCheckedModeBanner: false,
      home: widget.home,
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      localizationsDelegates: const [
        LocaleDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
