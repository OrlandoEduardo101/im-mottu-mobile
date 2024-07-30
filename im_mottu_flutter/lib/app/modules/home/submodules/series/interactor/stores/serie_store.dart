import 'package:get/get.dart';

import '../../../../../../shared/constants/constants.dart';
import '../../../../../../shared/services/analytics/analytics_service.dart';
import '../params/get_series_details_params.dart';
import '../repositories/i_series_repository.dart';
import '../states/serie_state.dart';

class SerieStore extends GetxController {
  SerieState state = SerieState.empty();
  final ISeriesRepository seriesRepository;
  final IAnalyticsService analyticsService;

  SerieStore(this.seriesRepository, this.analyticsService);

  Future<void> getComicDetail({String url = ''}) async {
    state = state.copyWith(
      status: SerieStateStatus.loading,
    );
    update();

    final result = await seriesRepository.getSerieDetails(GetSeriesDetailsParams(resourceUrl: url));
    if (result.$1 != null) {
      state = state.copyWith(
        status: SerieStateStatus.success,
        comicDetails: result.$1,
      );
      logSerieViewd(result.$1!.title);
    } else {
      state = state.copyWith(status: SerieStateStatus.error, errorMessage: result.$2);
    }
    update();
  }

  Future<void> logSerieViewd(String serieName) async {
    if (serieName.isNotEmpty) {
      await analyticsService.logEvent(
        kComicViewdEventTag,
        {kSerieViewdEventTag: serieName},
      );
    }
  }
}
