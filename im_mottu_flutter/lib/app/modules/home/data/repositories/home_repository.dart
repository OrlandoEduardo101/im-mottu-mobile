import 'dart:developer';

import 'package:im_mottu_flutter/env.dart';

import '../../../../shared/constants/constants.dart';
import '../../../../shared/errors/i_failure.dart';
import '../../../../shared/services/analytics/crashalytics_service.dart';
import '../../../../shared/services/connectivity/check_connectivity_service.dart';
import '../../../../shared/services/http_client/i_http_client.dart';
import '../../../../shared/services/local_storage/preferences_key_strings.dart';
import '../../../../shared/services/local_storage/shared_preferences_service.dart';
import '../../interactor/models/character_wrapper_model.dart';
import '../../interactor/params/get_character_list_params.dart';
import '../../interactor/repositories/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final IHttpClient httpClient;
  final ICheckConnectivityService checkConnectivityService;
  final ISharedPreferencesService sharedPreferencesService;
  final ICrashlyticsService crashlyticsService;

  HomeRepository(
      this.httpClient, this.checkConnectivityService, this.sharedPreferencesService, this.crashlyticsService);
  @override
  Future<(CharacterDataWrapper?, String errorMessage)> getCharacterListData(GetCharacterListParams params) async {
    try {
      final keyCache = '$kCharactersCacheKey-${params.offset}-${params.limit}';
      final hasConnectivvity = checkConnectivityService.checkConnectivitySnapshot;
      Map<String, dynamic> data = {};
      if (hasConnectivvity) {
        final dateTime = DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch.toString();
        final response = await httpClient.get(kCharactersEndpoint, params: {
          'ts': dateTime,
          'apikey': Env.apiKey,
          'hash': Env.apiHashKey(timeStamp: dateTime),
          'limit': '${params.limit}',
          'offset': '${params.offset}',
          if (params.nameFilter.isNotEmpty) 'name': params.nameFilter,
        });
        data = response.data;
        if (params.nameFilter.isEmpty) {
          sharedPreferencesService.saveCacheMap(key: keyCache, data: response.data);
        }
      } else {
        data = await sharedPreferencesService.readCacheMap(key: keyCache);
      }
      final characterData = CharacterDataWrapper.fromMap(data);
      return (characterData, '');
    } on IFailure catch (e, s) {
      log(e.toString());
      crashlyticsService.recordError(e, s);
      return (null, e.message);
    }
  }
}
