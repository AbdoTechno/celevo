import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/home/cubit/popular_persons_cubit.dart';
import 'package:celevo/features/home/cubit/popular_persons_state.dart';
import 'package:celevo/features/home/widgets/person_widget.dart';
import 'package:celevo/features/persons/view/person_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularPeopleWidget extends StatefulWidget {
  const PopularPeopleWidget({super.key});

  @override
  State<PopularPeopleWidget> createState() => _PopularPeopleWidgetState();
}

class _PopularPeopleWidgetState extends State<PopularPeopleWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<PopularPersonsCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PopularPersonsCubit, PopularPersonsState>(
        builder: (context, state) {
          if (state is PopularPersonsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is PopularPersonsError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.wifi_exclamationmark, size: 48.sp, color: AppColors.error),
                    SizedBox(height: 14.h),
                    Text(
                      'Failed to load persons',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      onPressed: () {
                        context.read<PopularPersonsCubit>().getPopularPersons();
                      },
                      icon: const Icon(CupertinoIcons.arrow_clockwise, size: 16),
                      label: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PopularPersonsSuccess) {
            final persons = state.filteredPersons;

            if (persons.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.search, size: 48.sp, color: AppColors.textMutedDark),
                      SizedBox(height: 12.h),
                      Text(
                        'No celebrities found',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Try adjusting your search or filters.',
                        style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              );
            }

            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.darkSurface,
              onRefresh: () async {
                await context.read<PopularPersonsCubit>().getPopularPersons(page: 1);
              },
              child: GridView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                padding: EdgeInsets.only(bottom: 16.h),
                itemCount: persons.length + (state.isLoadingMore ? 1 : 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  if (index == persons.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      ),
                    );
                  }

                  final person = persons[index];

                  return _TactilePersonCard(person: person);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _TactilePersonCard extends StatefulWidget {
  final PersonModel person;
  const _TactilePersonCard({required this.person});

  @override
  State<_TactilePersonCard> createState() => _TactilePersonCardState();
}

class _TactilePersonCardState extends State<_TactilePersonCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonView(personModel: widget.person),
          ),
        );
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: PersonWidget(person: widget.person),
        ),
      ),
    );
  }
}
