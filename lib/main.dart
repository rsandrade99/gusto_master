import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'config/injector.dart';
import 'data/models/gusto_model.dart';
import 'logic/preference_cubit/prefs_cubit.dart';
import 'logic/api_cubit/api_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjector();
  await Hive.initFlutter();
  Hive.registerAdapter(GustoModelAdapter());
  await Hive.openBox<GustoModel>('gustosBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PrefsCubit>(create: (_) => sl<PrefsCubit>()..loadGustos()),
        BlocProvider<ApiCubit>(create: (_) => sl<ApiCubit>()..fetchPokemons()),
      ],
      child: const GustoMasterApp(),
    ),
  );
}
