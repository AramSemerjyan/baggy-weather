import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';

class ThinTitleText extends StatelessWidget {
  final String text;

  const ThinTitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            color: AppColors.mainTextColor, fontWeight: FontWeight.w300));
  }
}
