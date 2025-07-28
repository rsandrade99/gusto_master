import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils/app_mayus.dart';
import '../../../data/models/pokemon_model.dart';
import '../../../logic/preference_cubit/prefs_cubit.dart';
import '../../../data/models/gusto_model.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/card_pokemon_widget.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: pokemon.name.toUpperCase()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PokemonInfoCard(
              name: pokemon.name,
              id: pokemon.id,
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
              height: (pokemon.height ?? 0.0 as num).toDouble(),
              weight: (pokemon.weight ?? 0.0 as num).toDouble(),
              types: pokemon.types ?? [],
              abilities: pokemon.abilities ?? [],
            ),

            ButtonAnimadoWidget(
              onPressed: () => _showAddGustoDialog(context),
              label: 'Agregar a gustos',
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showAddGustoDialog(BuildContext context) {
    final TextEditingController nombreController = TextEditingController(
      text: pokemon.name,
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Guardar "${capitalize(pokemon.name)}" en gustos',
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nombreController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Nombre personalizado',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.deepPurple,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor ingresa un nombre';
              }
              return null;
            },
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        actions: [
          Wrap(
            spacing: 10,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
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
              ButtonAnimadoWidget(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final nombre = nombreController.text.trim();

                    final prefsCubit = context.read<PrefsCubit>();
                    prefsCubit.addGusto(
                      GustoModel(
                        id: const Uuid().v4(),
                        nombre: nombre,
                        tipo: 'pokemon',
                        datosApi: {
                          'id': pokemon.id,
                          'name': pokemon.name,
                          'url': pokemon.url,
                          'imageUrl':
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
                          'height': pokemon.height,
                          'weight': pokemon.weight,
                          'types': pokemon.types,
                          'abilities': pokemon.abilities,
                        },
                      ),
                    );

                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gusto "$nombre" guardado!'),
                        backgroundColor: Colors.deepPurple,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                },
                label: 'Guardar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
