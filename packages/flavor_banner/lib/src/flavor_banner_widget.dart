import 'package:flutter/material.dart';

import 'environment.dart';

enum Flavor {
  production,
  staging,
  development,
  unknown,
}

extension FlavorString on Flavor {
  String get label {
    switch (this) {
      case Flavor.development:
        return 'dev';
      case Flavor.staging:
        return 'staging';
      case Flavor.production:
        return 'production';
      default:
        return 'unknown';
    }
  }
}

class FlavorBanner extends StatelessWidget {
  FlavorBanner({required this.child, this.flavor, this.labelBuilder});

  final Widget? child;
  final Flavor? flavor;
  final String Function(Flavor flavor)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    late Flavor _flavor;

    if (flavor == null) {
      if (EnvironmentFlavor.isDev) {
        _flavor = Flavor.development;
      } else if (EnvironmentFlavor.isStaging) {
        _flavor = Flavor.staging;
      } else if (EnvironmentFlavor.isProduction) {
        _flavor = Flavor.production;
      } else {
        _flavor = Flavor.unknown;
      }
    } else {
      _flavor = flavor!;
    }

    if (_flavor == Flavor.production) return child ?? const SizedBox.shrink();

    return Stack(
      children: <Widget>[
        child ?? const SizedBox.shrink(),
        _buildBanner(context, _flavor),
      ],
    );
  }

  Widget _buildBanner(BuildContext context, Flavor flavor) {
    return CustomPaint(
      painter: BannerPainter(
        message: labelBuilder?.call(flavor) ?? flavor.label.toUpperCase(),
        textDirection: Directionality.of(context),
        layoutDirection: Directionality.of(context),
        location: BannerLocation.topStart,
        color: Colors.orange,
      ),
    );
  }
}
