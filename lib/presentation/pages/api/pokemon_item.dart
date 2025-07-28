import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../core/utils/app_mayus.dart';
import '../../../data/models/pokemon_model.dart';

class PokemonListItem extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback onTap;

  const PokemonListItem({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.deepPurple.withOpacity(0.3),
        child: ListTile(
          leading: Hero(
            tag: 'pokemon-image-${pokemon.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.png',
                image: pokemon.imageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                imageErrorBuilder: (_, __, ___) =>
                    const Icon(Icons.error, size: 40, color: Colors.redAccent),
              ),
            ),
          ),
          title: Text(
            capitalize(pokemon.name),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          subtitle: Text(
            'ID: ${pokemon.id}',
            style: TextStyle(color: Colors.deepPurple.shade300),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.deepPurple,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          horizontalTitleGap: 12,
          minLeadingWidth: 56,
        ),
      ),
    );
  }
}

class PokemonSkeleton extends StatelessWidget {
  const PokemonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: SkeletonLoader(
        builder: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: CircleAvatar(radius: 30, backgroundColor: Colors.grey),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 15, color: Colors.grey.shade300),
                      const SizedBox(height: 8),
                      Container(height: 12, color: Colors.grey.shade300),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
