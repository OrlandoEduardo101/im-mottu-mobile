import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/states/home_state.dart';

import '../../../../shared/constants/constants.dart';
import '../../../../shared/services/analytics/analytics_service.dart';
import '../../../../shared/services/debouncer/debouncer_service.dart';
import '../models/result_character.dart';
import '../params/get_character_list_params.dart';
import '../repositories/i_home_repository.dart';

class HomeStore extends GetxController {
  HomeState state = HomeState.empty();
  final IHomeRepository homeRepository;
  final IDebouncerService debouncerService;
  final IAnalyticsService analyticsService;

  HomeStore(this.homeRepository, this.debouncerService, this.analyticsService);

  Future<void> getCharacters({String textName = '', int? offset}) async {
    state = state.copyWith(
        status: HomeStateStatus.loading,
        charactersListFiltered: offset != null && offset == 0 ? [] : null,
        charactersList: offset != null && offset == 0 ? [] : null);
    update();

    final result = await homeRepository.getCharacterListData(
        GetCharacterListParams(offset: offset ?? state.charactersList.length, nameFilter: textName));
    if (result.$1?.data.results != null) {
      final resultsList = <ResultCharacter>[
        ...state.charactersList,
        ...result.$1?.data.results ?? [],
      ];
      state = state.copyWith(
          status: HomeStateStatus.success, charactersList: resultsList, charactersListFiltered: resultsList);
    } else {
      state = state.copyWith(status: HomeStateStatus.error, errorMessage: result.$2);
    }
    update();
  }

  Future<void> getCharactersByText(String text) async {
    List<ResultCharacter> newListChar = state.charactersList;

    if (text.isNotEmpty) {
      newListChar = state.charactersList
          .where(
            (element) => element.name.toLowerCase().contains(text),
          )
          .toList();
    }
    state = state.copyWith(charactersListFiltered: newListChar);
    debouncerService.run(() {
      logCharacterSearched(text);
    });

    update();
  }

  Future<void> getCharactersByTextFromApi(String text) async {
    List<ResultCharacter> newListChar = state.charactersList;

    debouncerService.run(() {
      getCharacters(textName: text, offset: 0);

      state = state.copyWith(charactersListFiltered: newListChar);
      logCharacterSearched(text);

      update();
    });
  }

  Future<void> logCharacterViewed(String characterName) async {
    await analyticsService.logEvent(
      kCharacterViewdEventTag,
      {kCharacterNameEventTag: characterName},
    );
  }

  Future<void> logCharacterSearched(String characterName) async {
    await analyticsService.logEvent(
      kCharacterSearchEventTag,
      {kCharacterNameEventTag: characterName},
    );
  }
}
