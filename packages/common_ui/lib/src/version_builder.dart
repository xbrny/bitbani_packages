import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class VersionBuilder extends StatefulWidget {
  VersionBuilder({required this.builder});

  final Widget Function(
    BuildContext context,
    String value,
  )? builder;

  @override
  _VersionBuilderState createState() => _VersionBuilderState();
}

class _VersionBuilderState extends State<VersionBuilder> {
  String version = 'Loading version';
  String buildNumber = '';

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      try {
        final packageInfo = await PackageInfo.fromPlatform();
        version = 'v${packageInfo.version}';
        buildNumber = packageInfo.buildNumber;
      } catch (e) {
        version = 'Unknown version';
        buildNumber = '';
      } finally {
        if (mounted) setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = '$version ${(buildNumber).isNotEmpty ? '($buildNumber)' : ''}';

    return widget.builder!(context, text);
  }
}

class AppInfoDialog extends StatelessWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AppInfoDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('App info'),
      content: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, result) {
          if (!result.hasData) return const CircularProgressIndicator();
          if (result.hasError)
            return const Text(
              'Unable to get package info',
              textAlign: TextAlign.center,
            );

          String appName = result.data?.appName ?? '-';
          String packageName = result.data?.packageName ?? '-';
          String version = result.data?.version ?? '-';
          String buildNumber = result.data?.buildNumber ?? '-';

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('App name'),
                trailing: Text(appName),
                dense: true,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Package name'),
                trailing: Text(packageName),
                dense: true,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Version'),
                trailing: Text(version),
                dense: true,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Build number'),
                trailing: Text(buildNumber),
                dense: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
