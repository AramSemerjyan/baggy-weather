import 'package:flutter/material.dart';
import 'package:flutter_weather/Helper/Localization/languages.dart';
import 'package:flutter_weather/UI/Forecast/ColumnShortInfo/column_short_info.dart';

abstract class ForecastItemDetailsUIInterface {
  String get humidity;
  String get windSpeed;
  String get uv;
}

/// I'm wondering... should I move general padding info to the separate files?
/// I'm getting to paranoid when it gets to separating into separate files...
class ForecastDetailsView extends StatelessWidget {
  final String? humidity;
  final String? windSpeed;
  final String? uv;

  const ForecastDetailsView({Key? key, this.humidity, this.windSpeed, this.uv})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = humidity;
    final w = windSpeed;
    final u = uv;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        // alignment: WrapAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (h != null)
            _getItem(title: Languages.of(context).humidity, info: h),
          if (w != null)
            _getItem(title: Languages.of(context).windSpeed, info: w),
          if (u != null) _getItem(title: Languages.of(context).uv, info: u)
        ],
      ),
    );
  }

  Widget _getItem({required String title, required String info}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ColumnShortInfo(
        title: title,
        info: info,
      ),
    );
  }
}
