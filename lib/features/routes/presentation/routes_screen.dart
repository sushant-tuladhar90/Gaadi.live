import 'package:flutter/material.dart';

import '../../scanner/presentation/scanner_screen.dart';
import '../data/routes_content.dart';
import 'routes_view.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutesView(
      content: defaultRoutesContent,
      onScan: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ScannerScreen()),
        );
      },
    );
  }
}
