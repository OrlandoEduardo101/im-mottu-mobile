import 'dart:developer';

import 'package:im_mottu_flutter/env.dart';

import '../../../../shared/constants/constants.dart';
import '../../../../shared/errors/i_failure.dart';
import '../../../../shared/services/connectivity/check_connectivity_service.dart';
import '../../../../shared/services/http_client/i_http_client.dart';
import '../../../../shared/services/local_storage/preferences_key_strings.dart';
import '../../../../shared/services/local_storage/shared_preferences_service.dart';
import '../../interactor/models/character_wrapper_model.dart';
import '../../interactor/repositories/i_home_repository.dart';

class HomeRepository implements IHomeRepository {
  final IHttpClient httpClient;
  final ICheckConnectivityService checkConnectivityService;
  final ISharedPreferencesService sharedPreferencesService;

  HomeRepository(this.httpClient, this.checkConnectivityService, this.sharedPreferencesService);
  @override
  Future<(CharacterDataWrapper?, String errorMessage)> getCharacterListData() async {
    try {
      var hasConnectivvity = checkConnectivityService.checkConnectivitySnapshot;
      Map<String, dynamic> data = {};
      if (hasConnectivvity) {
        final dateTime = DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch.toString();
        final response = await httpClient.get(
          '$kCharactersEndpoint?ts=$dateTime&apikey=${Env.apiKey}&hash=${Env.apiHashKey(timeStamp: dateTime)}',
        );
        data = response.data;
        sharedPreferencesService.saveCacheMap(key: kCharactersCacheKey, data: response.data);
      } else {
        data = await sharedPreferencesService.readCacheMap(key: kCharactersCacheKey);
      }
      final characterData = CharacterDataWrapper.fromMap(data);
      return (characterData, '');
    } on IFailure catch (e) {
      log(e.toString());
      return (null, e.message);
    }
  }
}
