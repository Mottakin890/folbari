import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/home/presentation/widgets/category_combo_list.dart';

class CategoryTabBarSection extends StatelessWidget {
  const CategoryTabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.only(top: 24),
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.c27214D,
              unselectedLabelColor: AppColors.c86869E,
              indicatorColor: AppColors.cFFA451,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: REdgeInsets.symmetric(horizontal: 16),
              padding: REdgeInsets.only(left: 8), // 8 + 16 (labelPadding) = 24 alignment
              labelStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Brandon Grotesque',
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Brandon Grotesque',
              ),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Hottest'),
                Tab(text: 'Popular'),
                Tab(text: 'New combo'),
                Tab(text: 'Top'),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 180.h,
            child: const CategoryComboList(),
          ),
        ),
      ],
    );
  }
}
