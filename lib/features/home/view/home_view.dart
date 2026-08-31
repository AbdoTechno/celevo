import 'package:celevo/core/di/injection_container.dart';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/repos/popular_person_repo.dart';
import 'package:celevo/core/sizes/app_sizes.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/home/widgets/popular_people_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? selectedTopic;

  final repo = getIt<PopularPersonRepo>();

  PopularPersonModel? popularPersons;

  bool isLoading = true;

  Future<void> getPopularPersons() async {
    try {
      final data = await repo.getPopularPersons();

      if (!mounted) return;

      setState(() {
        popularPersons = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      debugPrint('Error getting popular persons: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    getPopularPersons();
  }

  @override
  Widget build(BuildContext context) {
    List<String> topics = [
      'Politics',
      'Sports',
      'Entertainment',
      'Business',
      'Science',
      'Technology',
      'Health',
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Celevo',
            style: Theme.of(
              context,
            ).textTheme.displayMedium,
          ),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.bell),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Gap(AppSizes.spacingHeight16),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                  ),
                ),
              ),

              Gap(AppSizes.spacingHeight16),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    final topic = topics[index];

                    final bool isSelected =
                        selectedTopic == topic;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTopic = isSelected
                              ? null
                              : topic;
                        });
                      },
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(24.0),
                            border: Border.all(
                              color: AppColors.darkBorder,
                            ),
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                          margin:
                              const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                          child: Center(
                            child: Text(
                              topic,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors
                                              .lightSurface,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Gap(AppSizes.spacingHeight16),

              PopularPeopleWidget(
                isLoading: isLoading,
                popularPersons: popularPersons,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
