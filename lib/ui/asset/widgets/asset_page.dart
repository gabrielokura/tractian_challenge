import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/component.dart';
import 'package:tractian_challenge/ui/asset/widgets/three_list_item.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class AssetPage extends StatelessWidget {
  const AssetPage({super.key});

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
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  minVerticalPadding: 0,
                  minTileHeight: 0,
                  horizontalTitleGap: 8,
                  title: ThreeListItem(
                      item: Component(
                          name: 'PRODUCTION AREA - RAW MATERIAL', depth: 0),
                      isExpandable: false),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
