import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoAlert extends StatelessWidget {
  final PackageInfo packageInfo;
  const InfoAlert({
    super.key, required this.packageInfo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: const Text('Spotwatch'),
          content: Container(
            height: 125,
            constraints:
                const BoxConstraints(maxHeight: 300),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Version:'),
                    Text(packageInfo.version)
                  ],
                ),
                Row(
                  children: [
                    const Text('Build #:'),
                    Text(packageInfo.buildNumber)
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
  }
}