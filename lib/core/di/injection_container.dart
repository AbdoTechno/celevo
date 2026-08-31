import 'package:celevo/core/network/api_service.dart';
import 'package:celevo/core/network/dio%20client/dio_api_service.dart';
import 'package:celevo/core/network/http_client/http_api_service.dart';
import 'package:celevo/core/repos/ai_chat_repo.dart';
import 'package:celevo/core/repos/favorites_repo.dart';
import 'package:celevo/core/repos/person_details_repo.dart';
import 'package:celevo/core/repos/popular_person_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

// Set to true to use Dio, or false to use HttpApiService
const bool useDioClient = true;

Future<void> setUpLocator() async {
  // 1. Network API Service (Switchable between Dio and Http)
  if (useDioClient) {
    getIt.registerLazySingleton<BaseApiService>(
      () => DioApiService(),
    );
  } else {
    getIt.registerLazySingleton<BaseApiService>(
      () => HttpApiService(),
    );
  }

  // 2. Repositories
  getIt.registerLazySingleton<PopularPersonRepo>(
    () => PopularPersonRepo(
      apiService: getIt<BaseApiService>(),
    ),
  );

  getIt.registerLazySingleton<PersonDetailsRepo>(
    () => PersonDetailsRepo(
      apiService: getIt<BaseApiService>(),
    ),
  );

  getIt.registerLazySingleton<FavoritesRepo>(
    () => FavoritesRepo(),
  );

  getIt.registerLazySingleton<AiChatRepo>(
    () => AiChatRepo(
      apiService: getIt<BaseApiService>(),
    ),
  );
}
