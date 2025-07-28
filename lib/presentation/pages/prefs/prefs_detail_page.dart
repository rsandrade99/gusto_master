import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_master/presentation/widgets/app_bar_widget.dart';
import 'package:hive/hive.dart';
import '../../../core/utils/app_mayus.dart';
import '../../../data/models/gusto_model.dart';
import '../../../logic/preference_cubit/prefs_cubit.dart';
import '../../widgets/card_pokemon_widget.dart';

class PrefsDetailPage extends StatelessWidget {
  final String id;

  const PrefsDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<GustoModel>('gustosBox');
    final gusto = box.get(id);

    if (gusto == null) {
      return const Scaffold(body: Center(child: Text('Gusto no encontrado')));
    }

    final datos = gusto.datosApi;
    final imageUrl = datos['imageUrl'] ?? '';
    final nombre = capitalize(datos['name'] ?? gusto.nombre);
    final idPokemon = datos['id'];
    final altura = (datos['height'] as num).toDouble();
    final peso = (datos['weight'] as num).toDouble();
    final tipos = (datos['types'] as List).cast<String>();
    final habilidades = (datos['abilities'] as List).cast<String>();

    return Scaffold(
      appBar: AppBarWidget(
        title: nombre.toUpperCase(),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                barrierDismissible: false, // no se cierra tocando fuera
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              size: 48,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Confirmar eliminación',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '¿Estás seguro de que quieres eliminar este elemento? Esta acción no se puede deshacer.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: BorderSide(color: Colors.grey.shade400),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 14,
                                  ),
                                  elevation: 6,
                                  shadowColor: Colors.redAccent.shade100,
                                ),
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

              if (confirm == true) {
                final prefsCubit = context.read<PrefsCubit>();
                await prefsCubit.deleteGusto(id);
                await prefsCubit.loadGustos();
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PokemonInfoCard(
              imageUrl: imageUrl,
              name: nombre,
              id: idPokemon,
              height: altura,
              weight: peso,
              types: tipos,
              abilities: habilidades,
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
