import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/favorites/cubit/favorites_cubit.dart';
import 'package:celevo/features/favorites/cubit/favorites_state.dart';
import 'package:celevo/features/favorites/widgets/favorite_person_card.dart';
import 'package:celevo/features/favorites/widgets/favorites_empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesView extends StatelessWidget {
  final bool isTab;

  const FavoritesView({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: (!isTab && Navigator.canPop(context))
            ? IconButton(
                icon: const Icon(CupertinoIcons.chevron_left),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final count = (state is FavoritesLoaded) ? state.favorites.length : 0;
            return Column(
              children: [
                Text(
                  'Saved Celebrities',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 18.sp,
                      ),
                ),
                if (count > 0) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '$count saved ${count == 1 ? 'celebrity' : 'celebrities'}',
                    style: TextStyle(
                      color: AppColors.textSecondaryDark,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is FavoritesLoaded) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              return const FavoritesEmptyState();
            }

            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              itemCount: favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final person = favorites[index];
                return FavoritePersonCard(person: person);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
