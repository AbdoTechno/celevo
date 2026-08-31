import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/home/cubit/popular_persons_cubit.dart';
import 'package:celevo/features/home/cubit/popular_persons_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentFilterList extends StatelessWidget {
  const DepartmentFilterList({super.key});

  static const List<String> _departments = [
    'Acting',
    'Directing',
    'Production',
    'Writing',
    'Sound',
    'Camera',
    'Editing',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularPersonsCubit, PopularPersonsState>(
      builder: (context, state) {
        final selectedDep = (state is PopularPersonsSuccess) ? state.selectedDepartment : null;

        return SizedBox(
          height: 38.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _departments.length + 1,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isAll = selectedDep == null;
                return GestureDetector(
                  onTap: () {
                    context.read<PopularPersonsCubit>().filterByDepartment(null);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isAll ? AppColors.primary : AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isAll ? AppColors.primary : AppColors.darkBorder,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: isAll ? Colors.black : Colors.white,
                          fontSize: 12.sp,
                          fontWeight: isAll ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }

              final dep = _departments[index - 1];
              final isSelected = selectedDep?.toLowerCase() == dep.toLowerCase();

              return GestureDetector(
                onTap: () {
                  context.read<PopularPersonsCubit>().filterByDepartment(dep);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.darkBorder,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dep,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: 12.sp,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
