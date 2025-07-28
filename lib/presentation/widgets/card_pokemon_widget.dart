import 'package:flutter/material.dart';

import '../../core/utils/app_mayus.dart';

class PokemonInfoCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int id;
  final double height;
  final double weight;
  final List<String> types;
  final List<String> abilities;

  const PokemonInfoCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.12),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'pokemon-image-$id',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.png',
                image: imageUrl,
                height: 200,
                fit: BoxFit.contain,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 300),
                imageErrorBuilder: (_, __, ___) => const Icon(
                  Icons.error,
                  size: 140,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ID con sombra sutil
          Text(
            '#$id',
            style: theme.textTheme.titleMedium!.copyWith(
              color: Colors.deepPurple.shade400,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.deepPurple.shade100,
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Nombre destacado con sombra y tracking
          Text(
            capitalize(name),
            style: theme.textTheme.headlineMedium!.copyWith(
              color: Colors.deepPurple.shade700,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
              shadows: [
                Shadow(
                  color: Colors.deepPurple.shade100.withOpacity(0.8),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Divider(color: Colors.deepPurple.shade100, thickness: 2),

          const SizedBox(height: 20),

          // Altura y Peso en fila con iconos con animación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconValue(
                Icons.height,
                'Altura',
                '${height.toStringAsFixed(1)} m',
              ),
              _buildIconValue(
                Icons.fitness_center,
                'Peso',
                '${weight.toStringAsFixed(1)} kg',
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Tipos con chips customizados con color y sombra
          _buildChipSection(
            icon: Icons.category,
            label: 'Tipos',
            values: types,
            chipColor: Colors.deepPurple.shade100,
            chipTextColor: Colors.deepPurple.shade900,
            chipShadow: Colors.deepPurple.shade300,
          ),

          const SizedBox(height: 22),

          // Habilidades con chips en otro estilo
          _buildChipSection(
            icon: Icons.flash_on,
            label: 'Habilidades',
            values: abilities,
            chipColor: Colors.deepPurple.shade50,
            chipTextColor: Colors.deepPurple.shade700,
            chipShadow: Colors.deepPurple.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildIconValue(IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade200.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.deepPurple.shade700, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildChipSection({
    required IconData icon,
    required String label,
    required List<String> values,
    required Color chipColor,
    required Color chipTextColor,
    required Color chipShadow,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.deepPurple.shade700),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: values.map((value) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: chipColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: chipShadow.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.deepPurpleAccent,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    capitalize(value),
                    style: TextStyle(
                      color: chipTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
