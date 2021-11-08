import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';

class BigTempText extends StatelessWidget {
  final String temp;

  const BigTempText({Key? key, required this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      temp,
      style: const TextStyle(
          fontSize: 35,
          color: AppColors.mainTextColor,
          fontWeight: FontWeight.bold),
    );
  }
}
