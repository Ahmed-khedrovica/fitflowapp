import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  static const _size = 120.0;
  static const _assetPath = 'assets/images/app_logo.svg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: SvgPicture.asset(
        _assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
