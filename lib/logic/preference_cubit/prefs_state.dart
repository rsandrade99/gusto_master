import '../../data/models/gusto_model.dart';

abstract class PrefsState {}

class PrefsLoading extends PrefsState {}

class PrefsLoaded extends PrefsState {
  final List<GustoModel> gustos;
  PrefsLoaded(this.gustos);
}

class PrefsError extends PrefsState {
  final String message;
  PrefsError(this.message);
}
