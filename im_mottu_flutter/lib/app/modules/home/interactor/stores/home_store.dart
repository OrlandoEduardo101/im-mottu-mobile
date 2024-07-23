import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/states/home_state.dart';

import '../models/result_character.dart';
import '../repositories/i_home_repository.dart';

class HomeStore extends GetxController {
  HomeState state = HomeState.empty();
  final IHomeRepository homeRepository;

  HomeStore(this.homeRepository);

  Future<void> getCharacters() async {
    state = state.copyWith(status: HomeStateStatus.loading);
    update();

    final result = await homeRepository.getCharacterListData();
    if (result.$1?.data.results != null) {
      final resultsList = result.$1?.data.results;
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

    update();
  }
}
