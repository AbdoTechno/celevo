import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_api_service.dart';
import 'package:celevo/core/repos/popular_person_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpLocator() async {
  getIt.registerLazySingleton<BaseApiService>(
    () => DioApiService(),
  );

  getIt.registerLazySingleton(
    () => PopularPersonRepo(
      apiService: getIt<BaseApiService>(),
    ),
  );
}
