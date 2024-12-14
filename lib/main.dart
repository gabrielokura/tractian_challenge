import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/ui/asset/widgets/asset_page.dart';
import 'package:tractian_challenge/ui/home/widgets/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TRACTIAN Challenge',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/asset', page: () => AssetPage()),
      ],
    );
  }
}
