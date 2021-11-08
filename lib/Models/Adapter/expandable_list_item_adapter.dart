import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_weather/Models/Adapter/forecast_list_adapter.dart';
import 'package:flutter_weather/UI/ExpandableList/expandable_list.dart';
import 'package:flutter_weather/UI/Forecast/ForecastDetailsView/forecast_details.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/bold_title_text.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/thin_title_text.dart';
import 'package:flutter_weather/UI/Image/cached_image.dart';

/// I write an adapter... I know that pattern! Huh? This is not how I supposed to use it?
class ExpandableListItemAdapter implements ExpandableListItemInterface {
  final ForecastListUIAdapter item;

  @override
  final int id;

  @override
  Widget get expandedValue => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ForecastDetailsView(
          humidity: item.humidity,
          uv: item.uv,
          windSpeed: item.windSpeed,
        ),
      );

  @override
  Widget get headerValue => ListTile(
        title: ThinTitleText(text: item.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImageWrapper(
              height: 20,
              width: 20,
              url: item.icon,
            ),
            BoldTitleText(text: item.temp)
          ],
        ),
      );

  ExpandableListItemAdapter({required this.item, required this.id});
}
