import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/home/cubit/popular_persons_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (val) {
          context.read<PopularPersonsCubit>().searchPersons(val);
        },
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'Search celebrities...',
          hintStyle: TextStyle(color: AppColors.textMutedDark, fontSize: 13.sp),
          prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.primary),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(CupertinoIcons.clear_circled_solid, color: AppColors.textMutedDark),
                  onPressed: () {
                    _controller.clear();
                    context.read<PopularPersonsCubit>().searchPersons('');
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        ),
      ),
    );
  }
}
