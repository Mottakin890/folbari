import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/widgets/app_shimmer.dart';

class RecommendedShimmer extends StatelessWidget {
  const RecommendedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: 3,
      separatorBuilder: (context, index) => Spacing.horizontal(16),
      itemBuilder: (context, index) {
        return Container(
          width: 152.w,
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: AppShimmer(width: 24.w, height: 24.h, borderRadius: BorderRadius.circular(12.r)),
              ),
              AppShimmer(width: 80.w, height: 75.h, borderRadius: BorderRadius.circular(40.r)),
              Spacing.vertical(8),
              AppShimmer(width: 100.w, height: 12.h),
              Spacing.vertical(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppShimmer(width: 40.w, height: 14.h),
                  AppShimmer(width: 24.w, height: 24.h, borderRadius: BorderRadius.circular(12.r)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
