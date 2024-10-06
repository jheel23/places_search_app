import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_search_app/screens/location_input_screen.dart';
import 'package:place_search_app/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideSense Assignment App',
      theme: AppTheme.instance.theme,
      home: const LocationInputScreen(),
    );
  }
}
