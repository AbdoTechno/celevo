import 'package:celevo/core/di/injection_container.dart';
import 'package:celevo/core/repos/popular_person_repo.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/home/cubit/popular_persons_cubit.dart';
import 'package:celevo/features/home/widgets/department_filter_list.dart';
import 'package:celevo/features/home/widgets/home_search_bar.dart';
import 'package:celevo/features/home/widgets/popular_people_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PopularPersonsCubit(getIt<PopularPersonRepo>())..getPopularPersons(),
      child: const _HomeViewBody(),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'Celevo',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          actions: [
            Builder(
              builder: (ctx) => IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_clockwise,
                  color: AppColors.textSecondaryDark,
                  size: 20.sp,
                ),
                tooltip: 'Refresh',
                onPressed: () {
                  ctx.read<PopularPersonsCubit>().getPopularPersons(page: 1);
                },
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Gap(8.h),

              // Search Bar
              const HomeSearchBar(),

              Gap(12.h),

              // Department filter
              const DepartmentFilterList(),

              Gap(14.h),

              // Popular Celebrities Grid
              const PopularPeopleWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
