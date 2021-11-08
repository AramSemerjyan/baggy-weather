import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/bold_title_text.dart';
import 'package:flutter_weather/UI/Forecast/GeneralTextViews/thin_title_text.dart';

class ColumnShortInfo extends StatelessWidget {
  final String title;
  final String info;

  const ColumnShortInfo({Key? key, required this.title, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ThinTitleText(text: title), BoldTitleText(text: info)],
    );
  }
}
