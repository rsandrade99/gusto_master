// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:uuid/uuid.dart';

// import '../../../data/models/gusto_model.dart';
// import '../../../data/models/pokemon_model.dart';

// class PrefsNewPage extends StatefulWidget {
//   final List<PokemonModel> pokemons;

//   const PrefsNewPage({super.key, required this.pokemons});

//   @override
//   State<PrefsNewPage> createState() => _PrefsNewPageState();
// }

// class _PrefsNewPageState extends State<PrefsNewPage> {
//   final TextEditingController _nombreController = TextEditingController();
//   PokemonModel? _pokemonSeleccionado;

//   void _guardar() async {
//     final nombre = _nombreController.text.trim();
//     if (nombre.isEmpty || _pokemonSeleccionado == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Por favor, ingresa nombre y selecciona un Pokémon'),
//         ),
//       );
//       return;
//     }

//     final nuevoGusto = GustoModel(
//       id: const Uuid().v4(),
//       nombre: nombre,
//       tipo: 'pokemon',
//       datosApi: {
//         'id': _pokemonSeleccionado!.id,
//         'name': _pokemonSeleccionado!.name,
//         'url': _pokemonSeleccionado!.url,
//         'imageUrl': _pokemonSeleccionado!.imageUrl,
//       },
//     );

//     final box = Hive.box<GustoModel>('gustosBox');
//     await box.put(nuevoGusto.id, nuevoGusto);

//     if (context.mounted) Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Nuevo gusto Pokémon')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nombreController,
//               decoration: const InputDecoration(
//                 labelText: 'Nombre personalizado',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<PokemonModel>(
//               decoration: const InputDecoration(
//                 labelText: 'Selecciona un Pokémon',
//                 border: OutlineInputBorder(),
//               ),
//               items: widget.pokemons
//                   .map(
//                     (p) => DropdownMenuItem(
//                       value: p,
//                       child: Text(
//                         p.name[0].toUpperCase() + p.name.substring(1),
//                       ),
//                     ),
//                   )
//                   .toList(),
//               onChanged: (p) => setState(() => _pokemonSeleccionado = p),
//               value: _pokemonSeleccionado,
//               isExpanded: true,
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: _guardar,
//               icon: const Icon(Icons.save),
//               label: const Text('Guardar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
