import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data/models/gusto_model.dart';
import 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  late Box<GustoModel> _box;

  PrefsCubit() : super(PrefsLoading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      _box = await Hive.openBox<GustoModel>('gustosBox');
      final gustos = _box.values.toList();
      emit(PrefsLoaded(gustos));
    } catch (e) {
      emit(PrefsError('Error al cargar los gustos: $e'));
    }
  }

  Future<void> loadGustos() async {
    try {
      final gustos = _box.values.toList();
      emit(PrefsLoaded(gustos));
    } catch (e) {
      emit(PrefsError('Error al cargar los gustos: $e'));
    }
  }

  Future<void> addGusto(GustoModel gusto) async {
    try {
      await _box.put(gusto.id, gusto);
      final gustosActualizados = _box.values.toList();
      emit(PrefsLoaded(gustosActualizados));
    } catch (e) {
      emit(PrefsError('Error al agregar el gusto: $e'));
    }
  }

  Future<void> deleteGusto(String id) async {
    try {
      await _box.delete(id);
      final gustosActualizados = _box.values.toList();
      emit(PrefsLoaded(gustosActualizados));
    } catch (e) {
      emit(PrefsError('Error al eliminar el gusto: $e'));
    }
  }
}
