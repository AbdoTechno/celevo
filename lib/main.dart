import 'package:celevo/core/di/injection_container.dart';
import 'package:celevo/core/repos/ai_chat_repo.dart';
import 'package:celevo/core/repos/favorites_repo.dart';
import 'package:celevo/core/theme/dark_theme.dart';
import 'package:celevo/features/chat/cubit/chat_cubit.dart';
import 'package:celevo/features/favorites/cubit/favorites_cubit.dart';
import 'package:celevo/features/home/view/main_nav_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    // If .env file is missing (e.g. CI/CD), fallback to default/empty
  }
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FavoritesCubit(getIt<FavoritesRepo>())..loadFavorites(),
            ),
            BlocProvider(
              create: (context) => ChatCubit(getIt<AiChatRepo>()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Celevo',
            theme: darkTheme,
            home: const MainNavScaffold(),
          ),
        );
      },
    );
  }
}