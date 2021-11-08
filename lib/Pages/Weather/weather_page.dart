import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';
import 'package:flutter_weather/Helper/Localization/languages.dart';
import 'package:flutter_weather/Helper/Mixins/ErrorHandling/error_handling.dart';
import 'package:flutter_weather/Models/Adapter/expandable_list_item_adapter.dart';
import 'package:flutter_weather/Models/Adapter/forecast_list_adapter.dart';
import 'package:flutter_weather/Pages/Weather/weather_bloc.dart';
import 'package:flutter_weather/Pages/Weather/weather_event.dart';
import 'package:flutter_weather/Pages/Weather/weather_state.dart';
import 'package:flutter_weather/UI/ExpandableList/expandable_list.dart';
import 'package:flutter_weather/UI/Forecast/CurrentForecast/forecast_info.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/thin_title_text.dart';
import 'package:flutter_weather/UI/Location/location_icon.dart';
import 'package:flutter_weather_bg/bg/weather_bg.dart';

/// I do my best for this screen... LOOK!! We have animated background...
/// well... for some cases... like... if it's raining... or snowing... good right?
/// or... you prefer a good readable code? oh... sorry... I'm not that type of person...
/// we don't do that here...
class WeatherPage extends StatelessWidget with ErrorHandlingMixin {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, ForecastState>(
        builder: (context, state) {
          if (state is ForecastLoadedComplete) {
            _handleError(state.error, context);
            return _getBody(context, state);
          } else {
            return _getLoader();
          }
        },
      ),
    );
  }

  Widget _getLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getBody(BuildContext context, ForecastLoadedComplete state) {
    return Stack(
      children: [
        _getWeatherBg(context, state),
        _getBlurContainer(context, state),
        _getMainBody(context, state),
      ],
    );
  }

  Widget _getWeatherBg(BuildContext context, ForecastLoadedComplete state) {
    return WeatherBg(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      weatherType: state.currentType,
    );
  }

  Widget _getBlurContainer(BuildContext context, ForecastLoadedComplete state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.fadedColor,
    );
  }

  Widget _getDropDown(BuildContext context, ForecastLoadedComplete state) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            color: AppColors.cardBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 20,
                child: DropdownButton<ForecastListType>(
                  dropdownColor: AppColors.cardBackgroundColor,
                  underline: Container(),
                  iconEnabledColor: AppColors.mainTextColor,
                  value: state.dropDownValue,
                  onChanged: (v) {
                    if (v != null) {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(ForecastChangeListType(type: v));
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: ForecastListType.hourly,
                      child: ThinTitleText(text: Languages.of(context).hourly),
                    ),
                    DropdownMenuItem(
                      value: ForecastListType.daily,
                      child: ThinTitleText(text: Languages.of(context).daily),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getMainBody(BuildContext context, ForecastLoadedComplete state) {
    final current = state.current;
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationIcon(location: state.locationName),
              if (current != null) CurrentForecast(model: current),
              _getDropDown(context, state),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SingleChildScrollView(
              child: ExpandableList(items: _getExpandableItem(state.list)),
            ),
          ),
        )
      ],
    ));
  }

  List<ExpandableListItemAdapter> _getExpandableItem(
      List<ForecastListUIAdapter> items) {
    List<ExpandableListItemAdapter> list = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      list.add(ExpandableListItemAdapter(item: item, id: i));
    }

    return list;
  }

  void _handleError(String? error, BuildContext context) {
    handleError(error, context);
  }
}
