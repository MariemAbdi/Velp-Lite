import 'package:flutter/material.dart';

class AppListview extends StatelessWidget {
  const AppListview(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      this.height,
      this.reverse = false,
      this.padding = EdgeInsets.zero,
      this.physics = const BouncingScrollPhysics()});

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final double? height;
  final ScrollPhysics physics;
  final bool reverse;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          padding: padding,
          physics: physics,
          reverse: reverse,
          scrollDirection: height == null ? Axis.vertical : Axis.horizontal,
          itemBuilder: itemBuilder),
    );
  }
}
