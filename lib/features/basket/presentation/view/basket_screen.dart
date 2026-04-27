import 'package:flutter/material.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/basket/presentation/widgets/basket_bottom_bar.dart';
import 'package:folbari/features/basket/presentation/widgets/basket_header.dart';
import 'package:folbari/features/basket/presentation/widgets/basket_items_list.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Column(
        children: [
          BasketHeader(),
          BasketItemsList(),
          BasketBottomBar(),
        ],
      ),
    );
  }
}
