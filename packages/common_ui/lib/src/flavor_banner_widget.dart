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
  const FlavorBanner({
    Key? key,
    required this.child,
    this.flavor,
    this.labelBuilder,
  }) : super(key: key);

  final Widget? child;
  final Flavor? flavor;
  final String Function(Flavor flavor)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    late Flavor localFlavor;

    if (flavor == null) {
      if (EnvironmentFlavor.isDev) {
        localFlavor = Flavor.development;
      } else if (EnvironmentFlavor.isStaging) {
        localFlavor = Flavor.staging;
      } else if (EnvironmentFlavor.isProduction) {
        localFlavor = Flavor.production;
      } else {
        localFlavor = Flavor.unknown;
      }
    } else {
      localFlavor = flavor!;
    }

    if (localFlavor == Flavor.production) {
      return child ?? const SizedBox.shrink();
    }

    return Stack(
      children: <Widget>[
        child ?? const SizedBox.shrink(),
        _buildBanner(context, localFlavor),
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
