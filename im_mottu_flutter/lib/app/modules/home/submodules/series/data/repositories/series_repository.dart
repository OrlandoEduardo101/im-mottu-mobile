import 'dart:developer';

import '../../../../../../shared/errors/i_failure.dart';
import '../../../../../../shared/services/analytics/crashalytics_service.dart';
import '../../../../../../shared/services/connectivity/check_connectivity_service.dart';
import '../../../../../../shared/services/http_client/i_http_client.dart';
import '../../../../../../shared/services/local_storage/preferences_key_strings.dart';
import '../../../../../../shared/services/local_storage/shared_preferences_service.dart';
import '../../interactor/models/serie_item_detail_model.dart';
import '../../interactor/params/get_series_details_params.dart';
import '../../interactor/repositories/i_series_repository.dart';

class SeriesRepository implements ISeriesRepository {
  final IHttpClient httpClient;
  final ICheckConnectivityService checkConnectivityService;
  final ISharedPreferencesService sharedPreferencesService;
  final ICrashlyticsService crashlyticsService;

  SeriesRepository(
      this.httpClient, this.checkConnectivityService, this.sharedPreferencesService, this.crashlyticsService);
  @override
  Future<(SerieItemDetailModel?, String errorMessage)> getSerieDetails(GetSeriesDetailsParams params) async {
    try {
      final keyCache = '$kSeriesCacheKey-${params.resourceUrl}';
      final hasConnectivvity = checkConnectivityService.checkConnectivitySnapshot;
      Map<String, dynamic> data = {};
      if (hasConnectivvity) {
        final response = await httpClient.get(
          params.resourceUrl,
        );
        data = response.data;
        sharedPreferencesService.saveCacheMap(key: keyCache, data: response.data);
      } else {
        data = await sharedPreferencesService.readCacheMap(key: keyCache);
      }
      final comicData =
          List.from(data['data']['results']).map((element) => SerieItemDetailModel.fromMap(element)).first;

      return (comicData, '');
    } on IFailure catch (e, s) {
      log(e.toString());
      crashlyticsService.recordError(e, s);
      return (null, e.message);
    }
  }
}
