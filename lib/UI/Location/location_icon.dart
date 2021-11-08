import 'package:flutter/material.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';

class LocationIcon extends StatelessWidget {
  final String location;

  const LocationIcon({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.location_pin,
                color: AppColors.mainTextColor,
                size: 17,
              ),
            ),
            Text(location,
                style: const TextStyle(
                    color: AppColors.mainTextColor, fontSize: 17))
          ],
        ),
      ),
    );
  }
}
