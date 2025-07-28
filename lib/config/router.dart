import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../logic/api_cubit/api_cubit.dart';
import '../logic/preference_cubit/prefs_cubit.dart';

import '../presentation/pages/splash/splash_page.dart';
import '../presentation/pages/api/api_list_page.dart';
import '../presentation/pages/api/pokemon_detail_page.dart';
import '../presentation/pages/prefs/prefs_list_page.dart';
import '../presentation/pages/prefs/prefs_detail_page.dart';

import '../data/models/pokemon_model.dart';
import 'injector.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash screen - ruta raíz
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (_, __) => const SplashPage(),
      ),

      // Ruta padre api-list
      GoRoute(
        path: '/api-list',
        name: 'apiList',
        builder: (_, __) => BlocProvider(
          create: (_) => sl<ApiCubit>()..fetchPokemons(),
          child: const ApiListPage(),
        ),
        routes: [
          // Hijo: detalle de Pokémon, recibe PokemonModel por extra
          GoRoute(
            path: 'pokemon-detail',
            name: 'pokemonDetail',
            builder: (context, state) {
              final pokemon = state.extra as PokemonModel;

              // Reusar PrefsCubit si está disponible arriba
              return BlocProvider.value(
                value: BlocProvider.of<PrefsCubit>(context),
                child: PokemonDetailPage(pokemon: pokemon),
              );
            },
          ),
          // Rutas para gestión de gustos
          GoRoute(
            path: 'prefs',
            name: 'prefsList',
            builder: (context, state) => BlocProvider(
              create: (_) => sl<PrefsCubit>()..loadGustos(),
              child: const PrefsListPage(),
            ),
            routes: [
              // Nueva creación de gusto
              // GoRoute(
              //   path: 'new',
              //   name: 'prefsNew',
              //   builder: (context, state) => BlocProvider.value(
              //     value: BlocProvider.of<PrefsCubit>(context),
              //     child: const PrefsNewPage(
              //       pokemons: [],
              //     ), // o state.extra si quieres dinamismo
              //   ),
              // ),

              // Detalle de gusto por ID
              GoRoute(
                path: ':id',
                name: 'prefsDetail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return BlocProvider.value(
                    value: BlocProvider.of<PrefsCubit>(context),
                    child: PrefsDetailPage(id: id),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
