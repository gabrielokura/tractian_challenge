import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/domain/models/three_item.dart';
import 'package:tractian_challenge/ui/asset/view_models/asset_viewmodel.dart';
import 'package:tractian_challenge/ui/asset/widgets/three_list_item.dart';
import 'package:tractian_challenge/ui/core/colors.dart';
import 'package:tractian_challenge/utils/state.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key, required this.viewModel});

  final AssetViewModel viewModel;

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  @override
  void initState() {
    widget.viewModel.load(Get.arguments as Company);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Assets',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFieldWidget(
                //   hintText: 'Buscar Ativo ou Local',
                //   controller: controller.searchTextEditingController,
                // ),
                const SizedBox(height: 10),
                // const FilterButtons(),
              ],
            ),
          ),
          const Divider(
            color: AppColors.divider,
            height: 0,
            thickness: 2,
          ),
          Obx(() {
            final state = widget.viewModel.state.value;
            if (state == PageState.loading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            return Expanded(
              child: ListView.builder(
                itemCount: widget.viewModel.items.length,
                itemBuilder: (context, index) {
                  final item = widget.viewModel.items[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    minVerticalPadding: 0,
                    minTileHeight: 0,
                    horizontalTitleGap: 8,
                    title: ThreeListItem(item: item, isExpandable: false),
                    onTap: () {},
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
