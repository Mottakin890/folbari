import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/widgets/app_shimmer.dart';

class OrderHistoryShimmer extends StatelessWidget {
  const OrderHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: REdgeInsets.all(24),
      itemCount: 5,
      separatorBuilder: (context, index) => Spacing.vertical(16),
      itemBuilder: (context, index) {
        return Container(
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppShimmer(width: 100.w, height: 16.h),
                  AppShimmer(width: 60.w, height: 24.h, borderRadius: BorderRadius.circular(20.r)),
                ],
              ),
              Spacing.vertical(24),
              AppShimmer(width: 200.w, height: 12.h),
              Spacing.vertical(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppShimmer(width: 80.w, height: 12.h),
                  AppShimmer(width: 50.w, height: 16.h),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
