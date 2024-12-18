import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            return _buildErrorState();
          }

          if (state == PageState.success) {
            return _buildButtons();
          }

          return _buildLoadingIndicator();
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Expanded(
      child: Center(
        child: Text('Carregamento falhou'),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildButtons() {
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
                    Get.toNamed('/asset', arguments: company);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
