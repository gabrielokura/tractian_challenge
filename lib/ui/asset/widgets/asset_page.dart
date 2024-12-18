import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/ui/asset/models/asset_filter_type.dart';
import 'package:tractian_challenge/ui/asset/view_models/asset_viewmodel.dart';
import 'package:tractian_challenge/ui/asset/widgets/empty_state.dart';
import 'package:tractian_challenge/ui/asset/widgets/filter_button.dart';
import 'package:tractian_challenge/ui/asset/widgets/search_query_field.dart';
import 'package:tractian_challenge/ui/asset/widgets/tree_list_item.dart';
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
    final arguments = Get.arguments;
    if (arguments is Company) {
      widget.viewModel.load(arguments);
    }

    super.initState();
  }

  final TextEditingController searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
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
                SearchQueryField(
                  controller: searchQueryController,
                  onSubmitted: (value) => widget.viewModel.onTypeQuery(value),
                ),
                const SizedBox(height: 10),
                _buildFilterButtons(),
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
              return _buildLoadingIndicator();
            }

            return _buildAssets();
          }),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Expanded(child: Center(child: CircularProgressIndicator.adaptive()));
  }

  Widget _buildAssets() {
    if (widget.viewModel.items.isEmpty) {
      return AssetsEmptyState();
    }

    return Expanded(
      child: ListView.builder(
        itemExtent: 40,
        padding: EdgeInsets.all(16),
        itemCount: widget.viewModel.items.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.viewModel.items.length) {
            return SizedBox(height: 30);
          }

          final item = widget.viewModel.items[index];

          return ListTile(
            key: ValueKey(item.id),
            contentPadding: EdgeInsets.zero,
            dense: true,
            minVerticalPadding: 0,
            minTileHeight: 0,
            horizontalTitleGap: 16,
            title: TreeListItem(
              item: item,
              isExpandable: item.hasChild,
              searchQuery: widget.viewModel.searchQuery.value,
            ),
            onTap: () => widget.viewModel.onTapItem(item),
          );
        },
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16,
        children: [
          FilterButton(
            text: 'Sensor de Energia',
            icon: Icons.bolt_outlined,
            isSelected:
                widget.viewModel.assetFilter.value == AssetFilterType.energy,
            onPress: () => widget.viewModel.onTapFilter(AssetFilterType.energy),
          ),
          FilterButton(
            text: 'Crítico',
            icon: Icons.info_outline,
            isSelected:
                widget.viewModel.filter.assetFilter == AssetFilterType.critical,
            onPress: () =>
                widget.viewModel.onTapFilter(AssetFilterType.critical),
          )
        ],
      ),
    );
  }
}
