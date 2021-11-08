import 'package:flutter/material.dart';
import 'package:flutter_weather/Helper/AppConfigs/app_colors.dart';

/// This was a pain... actually... I found that Flutter itself provide a great
/// widget for Expandable lists... and handle a lot of things itself... but...
/// that damn background color... my God... why is it depends on MaterailApp's
/// theme? Why??? I would write my own Expandable list if I have time...
/// but before that... just enjoy my horrible design of the app...
abstract class ExpandableListItemInterface {
  int get id;
  Widget get expandedValue;
  Widget get headerValue;
}

class ExpandableList extends StatefulWidget {
  final List<ExpandableListItemInterface> items;

  const ExpandableList({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.fadedColor,
      child: ExpansionPanelList.radio(
        children: widget.items
            .map<ExpansionPanelRadio>((ExpandableListItemInterface item) {
          return ExpansionPanelRadio(
              backgroundColor: AppColors.cardBackgroundColor,
              value: item.id,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return item.headerValue;
              },
              body: item.expandedValue);
        }).toList(),
      ),
    );
  }
}
