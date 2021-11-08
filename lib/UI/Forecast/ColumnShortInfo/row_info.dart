import 'package:flutter/material.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/bold_title_text.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/thin_title_text.dart';
import 'package:flutter_weather/UI/Image/cached_image.dart';

class ForecastRowInfo extends StatelessWidget {
  final String title;
  final String temp;
  final String icon;

  const ForecastRowInfo(
      {Key? key, required this.title, required this.temp, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ThinTitleText(text: title),
        const Spacer(),
        CachedNetworkImageWrapper(
          height: 20,
          width: 20,
          url: icon,
        ),
        BoldTitleText(text: temp)
      ],
    );
  }
}
