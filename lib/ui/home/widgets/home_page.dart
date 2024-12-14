import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/data/services/api/api_client.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/ui/core/colors.dart';
import 'package:tractian_challenge/ui/home/view_models/home_viewmodel.dart';
import 'package:tractian_challenge/ui/home/widgets/company_button.dart';
import 'package:tractian_challenge/utils/state.dart';

import '../../../config/assets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.viewModel});

  final HomeViewModel viewModel;

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
      body: Obx(
        () {
          final state = viewModel.state.value;

          if (state == PageState.error) {
            return Center(
              child: Text('Carregamento falhou'),
            );
          }

          if (state == PageState.success) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 32,
                  children: viewModel.companies
                      .map(
                        (company) => CompanyButton(
                          text: company.name,
                          onPressed: () async {
                            Get.toNamed('/asset');
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
