import 'package:celevo/core/di/injection_container.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/repos/person_details_repo.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/persons/cubit/person_details_cubit.dart';
import 'package:celevo/features/persons/cubit/person_details_state.dart';
import 'package:celevo/features/persons/widgets/person_biography_section.dart';
import 'package:celevo/features/persons/widgets/person_hero_app_bar.dart';
import 'package:celevo/features/persons/widgets/person_known_for_list.dart';
import 'package:celevo/features/persons/widgets/person_personal_details_card.dart';
import 'package:celevo/features/persons/widgets/person_photo_gallery.dart';
import 'package:celevo/features/persons/widgets/person_quick_info.dart';
import 'package:celevo/features/persons/widgets/section_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonView extends StatelessWidget {
  final PersonModel personModel;

  const PersonView({super.key, required this.personModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = PersonDetailsCubit(getIt<PersonDetailsRepo>());
        if (personModel.id != null) {
          cubit.fetchPersonFullData(personModel.id!);
        }
        return cubit;
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
          builder: (context, state) {
            final details = (state is PersonDetailsSuccess) ? state.details : null;
            final images = (state is PersonDetailsSuccess) ? state.images : null;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Hero App Bar
                PersonHeroAppBar(personModel: personModel),

                // 2. Body Details Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 40.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Loading indicator
                        if (state is PersonDetailsLoading)
                          Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            child: const LinearProgressIndicator(
                              color: AppColors.primary,
                              backgroundColor: Colors.transparent,
                            ),
                          ),

                        // Quick Info
                        PersonQuickInfo(
                          personModel: personModel,
                          details: details,
                        ),

                        SizedBox(height: 24.h),

                        // Personal details (Birthday, place of birth)
                        if (details != null) ...[
                          PersonPersonalDetailsCard(details: details),
                          SizedBox(height: 24.h),
                        ],

                        // Biography Header & Content
                        const SectionHeaderWidget(
                          title: 'Biography',
                          icon: CupertinoIcons.doc_text,
                        ),

                        SizedBox(height: 12.h),

                        PersonBiographySection(biography: details?.biography),

                        SizedBox(height: 28.h),

                        // Photos Gallery Header & Content
                        SectionHeaderWidget(
                          title: 'Photo Gallery',
                          icon: CupertinoIcons.photo_on_rectangle,
                          trailing: images?.profiles != null && images!.profiles!.isNotEmpty
                              ? '${images.profiles!.length} Photos'
                              : null,
                        ),

                        SizedBox(height: 14.h),

                        PersonPhotoGallery(
                          personModel: personModel,
                          images: images,
                        ),

                        SizedBox(height: 28.h),

                        // Known For Works
                        if (personModel.knownFor != null && personModel.knownFor!.isNotEmpty) ...[
                          const SectionHeaderWidget(
                            title: 'Known For',
                            icon: CupertinoIcons.film,
                          ),
                          SizedBox(height: 14.h),
                          PersonKnownForList(knownFor: personModel.knownFor!),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
