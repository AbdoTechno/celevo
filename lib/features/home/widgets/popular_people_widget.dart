import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/sizes/app_sizes.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:celevo/features/home/widgets/person_widget.dart';
import 'package:celevo/features/persons/view/person_view.dart';
import 'package:flutter/material.dart';

class PopularPeopleWidget extends StatelessWidget {
  const PopularPeopleWidget({
    super.key,
    required this.isLoading,
    required this.popularPersons,
  });

  final bool isLoading;
  final PopularPersonModel? popularPersons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : popularPersons?.results == null ||
                popularPersons!.results!.isEmpty
          ? const Center(
              child: Text('No popular persons found'),
            )
          : GridView.builder(
              itemCount: popularPersons!.results!.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
              itemBuilder: (context, index) {
                final person =
                    popularPersons!.results![index];

                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PersonView(
                                  personModel: person,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSizes.spacingHeight8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withValues(alpha: 0.35),
                              blurRadius: 18,
                              spreadRadius: 1,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: AppColors.primary
                                  .withValues(alpha: 0.08),
                              blurRadius: 20,
                              spreadRadius: -4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: PersonWidget(person: person),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
