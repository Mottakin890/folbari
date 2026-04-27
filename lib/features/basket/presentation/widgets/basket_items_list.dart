import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_state.dart';
import 'package:folbari/features/basket/presentation/widgets/basket_item_widget.dart';

class BasketItemsList extends StatelessWidget {
  const BasketItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          BlocSelector<BasketBloc, BasketState, (bool, List<BasketItemEntity>)>(
            selector: (state) => (state.isLoading, state.items),
            builder: (context, data) {
              final (isLoading, items) = data;

              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'Your basket is empty',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.c86869E,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                );
              }
              return ListView.separated(
                padding: REdgeInsets.all(24),
                itemCount: items.length,
                separatorBuilder: (context, index) => Spacing.vertical(24),
                itemBuilder: (context, index) {
                  return BasketItemWidget(item: items[index]);
                },
              );
            },
          ),
    );
  }
}
