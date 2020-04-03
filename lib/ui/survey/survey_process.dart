import 'package:flutter/material.dart';

class SurveyProcess extends StatelessWidget {
  const SurveyProcess(this.min, this.max);

  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width - 150;
    const double height = 16;
    final double minWidth = ((min + 2) / (max + 2)) * maxWidth;
    final Color color = Theme.of(context).primaryColor;
    return Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Container(
          height: height,
          width: minWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withAlpha(100),
                color,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
