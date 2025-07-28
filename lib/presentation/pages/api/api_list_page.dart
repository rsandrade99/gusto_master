import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/pokemon_model.dart';
import '../../../logic/api_cubit/api_cubit.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widget.dart';
import 'pokemon_item.dart';

class ApiListPage extends StatefulWidget {
  const ApiListPage({super.key});

  @override
  State<ApiListPage> createState() => _ApiListPageState();
}

class _ApiListPageState extends State<ApiListPage> {
  late ApiCubit _apiCubit;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _apiCubit = context.read<ApiCubit>();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Pokédex',
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt, color: Colors.white),
            tooltip: 'Ver gustos guardados',
            onPressed: () {
              context.goNamed('prefsList');
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            tooltip: 'Acerca de',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.deepPurple,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'GustoMaster',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'v1.0.0',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const Divider(height: 32, thickness: 1),
                          const Text(
                            'Desarrollado por Robert Andrade',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 21),
                          ButtonAnimadoWidget(
                            onPressed: () => Navigator.pop(context),
                            label: 'Cerrar',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ApiCubit, ApiState>(
        builder: (context, state) {
          final isLoading = state is ApiLoading;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: _searchController,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Buscar Pokémon',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                    ),
                    filled: true,
                    fillColor: isLoading
                        ? Colors.grey.shade200
                        : Colors.deepPurple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.deepPurple.shade400,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: isLoading ? Colors.grey : Colors.deepPurple,
                  ),
                  cursorColor: Colors.deepPurple.shade700,
                ),
              ),
              Expanded(child: _buildBody(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(ApiState state) {
    if (state is ApiLoading) return _buildSkeletonLoader();
    if (state is ApiSuccess) {
      final filtered = state.pokemons
          .where((p) => p.name.toLowerCase().contains(_searchText))
          .toList();

      if (filtered.isEmpty) {
        return const Center(
          child: Text(
            'Sin resultados',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () => _apiCubit.fetchPokemons(),
        color: Colors.deepPurple,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return PokemonListItem(
              pokemon: filtered[index],
              onTap: () => _openDetail(filtered[index]),
            );
          },
        ),
      );
    }

    if (state is ApiError) return _buildError(state.message);

    return const Center(child: Text('Estado desconocido'));
  }

  void _openDetail(PokemonModel pokemon) {
    FocusScope.of(context).unfocus();
    context.goNamed('pokemonDetail', extra: pokemon);
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 8,
      itemBuilder: (context, index) => const PokemonSkeleton(),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _apiCubit.fetchPokemons(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Reintentar',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
