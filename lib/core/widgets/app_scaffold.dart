import 'package:flutter/material.dart';
import 'package:velp_lite/core/widgets/sidebar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final String currentRoute; // Added to pass to SideBar to get selected item

  const AppScaffold({
    required this.body,
    required this.currentRoute,
    this.appBar,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: SideBar(currentRoute: currentRoute),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
