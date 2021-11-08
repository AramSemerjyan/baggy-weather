import 'package:flutter/material.dart';
import 'package:flutter_weather/UI/Forecast/ForecastDetailsView/forecast_details.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/big_temp_text.dart';
import 'package:flutter_weather/UI/Image/cached_image.dart';

abstract class ForecastDateUIInterface {
  String get hour;
  String get day;
}

abstract class ForecastItemlUIInterface
    implements ForecastItemDetailsUIInterface, ForecastDateUIInterface {
  String get temp;
  String get shortTemp;
  String get feelsLike;
  String get icon;
}

class CurrentForecast extends StatelessWidget {
  final ForecastItemlUIInterface model;

  const CurrentForecast({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [BigTempText(temp: model.temp)],
            ),
            const Spacer(),
            CachedNetworkImageWrapper(
              height: 100,
              width: 100,
              url: model.icon,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ForecastDetailsView(
            humidity: model.humidity,
            windSpeed: model.windSpeed,
            uv: model.uv,
          ),
        )
      ],
    );
  }
}
