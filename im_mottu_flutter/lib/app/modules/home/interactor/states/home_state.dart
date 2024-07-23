import '../models/result_character.dart';

enum HomeStateStatus {
  loading,
  success,
  error;
}

class HomeState {
  final HomeStateStatus status;

  final String errorMessage;
  final List<ResultCharacter> charactersList;
  final List<ResultCharacter> charactersListFiltered;
  HomeState({
    required this.status,
    required this.errorMessage,
    required this.charactersList,
    required this.charactersListFiltered,
  });

  static HomeState empty() => HomeState(
        status: HomeStateStatus.loading,
        errorMessage: '',
        charactersList: [],
        charactersListFiltered: [],
      );

  HomeState copyWith({
    HomeStateStatus? status,
    String? errorMessage,
    List<ResultCharacter>? charactersList,
    List<ResultCharacter>? charactersListFiltered,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      charactersList: charactersList ?? this.charactersList,
      charactersListFiltered: charactersListFiltered ?? this.charactersListFiltered,
    );
  }
}
