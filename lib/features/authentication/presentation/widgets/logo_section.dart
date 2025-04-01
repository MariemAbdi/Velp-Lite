// widgets/logo_section.dart
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_paths.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Image.asset(
          AssetsPaths.logo,
          height: 130,
        ),
        Text("VELP LITE", style: textTheme.labelLarge),
        Text(
          "Hi! Welcome back, you've been missed",
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
