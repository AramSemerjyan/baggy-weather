import 'package:flutter/material.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';

class BoldTitleText extends StatelessWidget {
  final String text;

  const BoldTitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            color: AppColors.mainTextColor, fontWeight: FontWeight.bold));
  }
}
