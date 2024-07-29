import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/repositories/i_comics_repository.dart';

import '../../../../../../shared/constants/constants.dart';
import '../../../../../../shared/services/analytics/analytics_service.dart';
import '../params/get_comics_details_params.dart';
import '../states/comics_state.dart';

class ComicStore extends GetxController {
  ComicsState state = ComicsState.empty();
  final IComicsRepository comicsRepository;
  final IAnalyticsService analyticsService;

  ComicStore(this.comicsRepository, this.analyticsService);

  Future<void> getComicDetail({String url = ''}) async {
    state = state.copyWith(
      status: ComicsStateStatus.loading,
    );
    update();

    final result = await comicsRepository.getComicDetails(GetComicsDetailsParams(resourceUrl: url));
    if (result.$1 != null) {
      state = state.copyWith(
        status: ComicsStateStatus.success,
        comicDetails: result.$1,
      );
    } else {
      state = state.copyWith(status: ComicsStateStatus.error, errorMessage: result.$2);
    }
    update();
  }

  Future<void> logCharacterViewed(String characterName) async {
    await analyticsService.logEvent(
      kCharacterViewdEventTag,
      {kCharacterNameEventTag: characterName},
    );
  }
}
