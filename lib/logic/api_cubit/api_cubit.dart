import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/pokemon_model.dart';
import '../../data/repositories/api_repository.dart';
import '../../config/injector.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final ApiRepository _repository;

  ApiCubit(ApiRepository apiRepository)
    : _repository = sl<ApiRepository>(),
      super(ApiInitial());

  Future<void> fetchPokemons() async {
    emit(ApiLoading());
    try {
      final pokemons = await _repository.fetchPokemons();
      emit(ApiSuccess(pokemons));
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }
}
