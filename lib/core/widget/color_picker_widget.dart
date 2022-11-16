import 'package:flutter/material.dart';

import '../const/const.dart';

class ColorPickerWidget extends StatelessWidget {
  final List colors;
  final int currentActiveTab;
  final int currentWidgetIndex;
  final BuildContext context;

  const ColorPickerWidget(
      {super.key,
      required this.colors,
      required this.currentActiveTab,
      required this.currentWidgetIndex,
      required this.context});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p4),
      child: Container(
        height: AppHeight.h70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppRadius.r10,
          ),
          color: Theme.of(context).backgroundColor,
          border: Border.all(
            color: currentActiveTab == currentWidgetIndex
                ? AppColors.buttonColor
                : Theme.of(context).backgroundColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Center(
            child: CircleAvatar(
              backgroundColor: colors[currentWidgetIndex],
            ),
          ),
        ),
      ),
    );
  }
}
