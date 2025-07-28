import 'package:get_it/get_it.dart';
import '../data/repositories/api_repository.dart';
import '../logic/api_cubit/api_cubit.dart';
import '../logic/preference_cubit/prefs_cubit.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
  // Repositorios
  sl.registerLazySingleton<ApiRepository>(() => ApiRepositoryImpl());

  // Cubits
  sl.registerFactory<ApiCubit>(() => ApiCubit(sl<ApiRepository>()));
  sl.registerFactory<PrefsCubit>(() => PrefsCubit());
}
