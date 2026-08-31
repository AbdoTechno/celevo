import 'package:cached_network_image/cached_network_image.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/favorites/cubit/favorites_cubit.dart';
import 'package:celevo/features/favorites/cubit/favorites_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({super.key, required this.person});

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Profile Image with caching
          person.profilePath != null
              ? CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${person.profilePath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.darkSurface,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return _buildPlaceholder();
                  },
                )
              : _buildPlaceholder(),

          /// Dark bottom gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.45),
                    Colors.black.withValues(alpha: 0.92),
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),

          /// Favorite button (Red if in favorites, White/Gray border if not)
          Positioned(
            top: 10,
            right: 10,
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFav = (state is FavoritesLoaded) && state.isFavorite(person.id);

                return Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isFav
                        ? AppColors.favorite.withValues(alpha: 0.25)
                        : Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isFav
                          ? AppColors.favorite
                          : Colors.white.withValues(alpha: 0.25),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      size: 18,
                      color: isFav ? AppColors.favorite : Colors.white,
                    ),
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(person);
                    },
                  ),
                );
              },
            ),
          ),

          /// Person information
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  person.name ?? 'Unknown',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        person.knownForDepartment ?? 'Actor',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.darkSurface,
      child: const Center(
        child: Icon(
          CupertinoIcons.person_fill,
          size: 48,
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }
}
