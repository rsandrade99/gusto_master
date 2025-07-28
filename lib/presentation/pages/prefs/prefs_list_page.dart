import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_mayus.dart';
import '../../../logic/preference_cubit/prefs_cubit.dart';
import '../../../logic/preference_cubit/prefs_state.dart';
import '../../widgets/app_bar_widget.dart';

class PrefsListPage extends StatelessWidget {
  const PrefsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prefsCubit = context.read<PrefsCubit>();

    return Scaffold(
      appBar: AppBarWidget(title: 'Mis gustos'),
      body: BlocBuilder<PrefsCubit, PrefsState>(
        builder: (context, state) {
          if (state is PrefsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrefsLoaded) {
            if (state.gustos.isEmpty) {
              return const Center(
                child: Text(
                  'No tienes gustos aún.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => await prefsCubit.loadGustos(),
              color: Colors.deepPurple,
              displacement: 30,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: state.gustos.length,
                itemBuilder: (context, index) {
                  final gusto = state.gustos[index];

                  return GestureDetector(
                    onTap: () => context.go('/api-list/prefs/${gusto.id}'),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.deepPurple.shade100,
                              child: Text(
                                gusto.nombre.isNotEmpty
                                    ? gusto.nombre[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    capitalize(gusto.nombre),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tipo: ${gusto.tipo}',
                                    style: TextStyle(
                                      color: Colors.deepPurple.shade300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.deepPurple,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Error cargando gustos.',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
