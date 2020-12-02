import 'package:flutter/material.dart';

class WidgetCounter extends StatelessWidget {
  WidgetCounter(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
