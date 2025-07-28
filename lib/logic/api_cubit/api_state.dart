part of 'api_cubit.dart';

abstract class ApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiSuccess extends ApiState {
  final List<PokemonModel> pokemons;

  ApiSuccess(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}

class ApiError extends ApiState {
  final String message;

  ApiError(this.message);

  @override
  List<Object?> get props => [message];
}
