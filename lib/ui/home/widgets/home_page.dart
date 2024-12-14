import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/ui/core/colors.dart';
import 'package:tractian_challenge/ui/home/widgets/company_button.dart';

import '../../../config/assets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        title: const Image(
          image: AssetImage(Assets.logo),
          width: 130,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 32,
            children: [
              CompanyButton(
                text: 'Jaguar Unit',
                onPressed: () {
                  Get.toNamed('/asset');
                },
              ),
              CompanyButton(
                text: 'Tobias Unit',
                onPressed: () {
                  Get.toNamed('/asset');
                },
              ),
              CompanyButton(
                text: 'Apex Unit',
                onPressed: () {
                  Get.toNamed('/asset');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
