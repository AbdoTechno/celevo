import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/sizes/app_sizes.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({super.key, required this.person});

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          /// Image
          SizedBox(
            width: double.infinity,
            height: AppSizes.spacingHeight250,
            child: person.profilePath != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w500${person.profilePath}',
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                          return Container(
                            color: AppColors.darkSurface,
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.person_fill,
                                size: 48,
                                color:
                                    AppColors.textMutedDark,
                              ),
                            ),
                          );
                        },
                  )
                : Container(
                    color: AppColors.darkSurface,
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.person_fill,
                        size: 48,
                        color: AppColors.textMutedDark,
                      ),
                    ),
                  ),
          ),

          /// Bottom gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.88),
                  ],
                  stops: const [0.0, 0.42, 0.65, 1.0],
                ),
              ),
            ),
          ),

          /// Favorite button
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.18,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.25,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 22,
                icon: const Icon(
                  CupertinoIcons.heart,
                  size: 19,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),

          /// Person information
          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name ?? 'Unknown',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 5),

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
                            color: AppColors.primary
                                .withValues(alpha: 0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        person.knownForDepartment ??
                            'Unknown',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: Colors.white
                                  .withValues(alpha: 0.72),
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
}
