import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/routes/app_pages.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_state.dart';
import 'package:folbari/features/home/presentation/widgets/category_combo_list.dart';
import 'package:folbari/features/home/presentation/widgets/greetings_section.dart';
import 'package:folbari/features/home/presentation/widgets/home_header.dart';
import 'package:folbari/features/home/presentation/widgets/recommended_combo_list.dart';
import 'package:folbari/features/home/presentation/widgets/search_section.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.unauthenticated) {
              context.go(AppPages.auth);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 24, vertical: 12),
                sliver: const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
              ),

              // Greeting Section
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 24),
                sliver: const SliverToBoxAdapter(child: GreetingsSection()),
              ),

              // Search Section
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 24, vertical: 24),
                sliver: const SliverToBoxAdapter(child: SearchSection()),
              ),

              // Recommended Combo Title
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Recommended Combo',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.c27214D,
                      fontFamily: 'Brandon Grotesque',
                    ),
                  ),
                ),
              ),

              // Recommended Combo List
              SliverToBoxAdapter(
                child: SizedBox(height: 220.h, child: const RecommendedComboList()),
              ),

              // Tabs
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppColors.c27214D,
                    unselectedLabelColor: AppColors.c86869E,
                    indicatorColor: AppColors.cFFA451,
                    indicatorSize: TabBarIndicatorSize.tab,
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

              // Tab View Content
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180.h,
                  child: const CategoryComboList(),
                ),
              ),

              SliverSpacing.vertical(20),
            ],
          ),
        ),
      ),
    );
  }
}
