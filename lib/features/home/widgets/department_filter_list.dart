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
    'Writing',
    'Production',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularPersonsCubit, PopularPersonsState>(
      builder: (context, state) {
        final selectedDep = (state is PopularPersonsSuccess) ? state.selectedDepartment : null;

        return SizedBox(
          height: 36.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _departments.length + 1,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isAll = selectedDep == null;
                return _buildChip(
                  label: 'All',
                  isSelected: isAll,
                  onTap: () {
                    context.read<PopularPersonsCubit>().filterByDepartment(null);
                  },
                );
              }

              final dep = _departments[index - 1];
              final isSelected = selectedDep?.toLowerCase() == dep.toLowerCase();

              return _buildChip(
                label: dep,
                isSelected: isSelected,
                onTap: () {
                  context.read<PopularPersonsCubit>().filterByDepartment(dep);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkBorder,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12.5.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
