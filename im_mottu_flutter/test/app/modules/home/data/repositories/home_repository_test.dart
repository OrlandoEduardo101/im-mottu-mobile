import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:im_mottu_flutter/app/modules/home/data/repositories/home_repository.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/models/character_wrapper_model.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/params/get_character_list_params.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/repositories/i_home_repository.dart';
import 'package:im_mottu_flutter/app/shared/errors/datasource_error.dart';
import 'package:im_mottu_flutter/app/shared/errors/http_client_error.dart';
import 'package:im_mottu_flutter/app/shared/services/analytics/crashalytics_service.dart';
import 'package:im_mottu_flutter/app/shared/services/connectivity/check_connectivity_service.dart';
import 'package:im_mottu_flutter/app/shared/services/http_client/http_response.dart';
import 'package:im_mottu_flutter/app/shared/services/http_client/i_http_client.dart';
import 'package:im_mottu_flutter/app/shared/services/local_storage/shared_preferences_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../../data.dart';

class HttpClientMock extends Mock implements IHttpClient {}

class CheckConnectivityMock extends Mock implements ICheckConnectivityService {}

class StorageMock extends Mock implements ISharedPreferencesService {}

class CrashAlyticsMock extends Mock implements ICrashlyticsService {}

class StackTraceFake extends Fake implements StackTrace {}

main() {
  late final IHomeRepository repository;
  late final IHttpClient httpClient;
  late final ICheckConnectivityService connectivityService;
  late final ISharedPreferencesService storage;
  late final ICrashlyticsService crashlyticsService;

  setUpAll(() {
    httpClient = HttpClientMock();
    connectivityService = CheckConnectivityMock();
    storage = StorageMock();
    crashlyticsService = CrashAlyticsMock();
    repository = HomeRepository(httpClient, connectivityService, storage, crashlyticsService);

    registerFallbackValue(StackTraceFake());

    when(() => crashlyticsService.recordError(any(), any())).thenAnswer((_) async => true);
  });

  group('Get character list', () {
    test('Must return a CharacterDataWrapper with a list characters when http client return response with success',
        () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params')))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(apiResponseJson), statusCode: 200));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(true);

      when(() => storage.saveCacheMap(key: any(named: 'key'), data: any(named: 'data'))).thenAnswer((_) async => true);

      // act
      final result = await repository.getCharacterListData(GetCharacterListParams(offset: 10));

      // assert
      expect(result.$1, isA<CharacterDataWrapper>());
      expect(result.$1?.data.results.isNotEmpty, true);
      expect(result.$2.isEmpty, true);
    });

    test('Must return a CharacterDataWrapper with a list characters when local storage return response with success',
        () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params')))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(apiResponseJson), statusCode: 200));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(false);

      when(() => storage.readCacheMap(
            key: any(named: 'key'),
          )).thenAnswer((_) async => jsonDecode(apiResponseJson));

      // act
      final result = await repository.getCharacterListData(GetCharacterListParams(offset: 10));

      // assert
      verifyNever(() => httpClient.get(''));
      expect(result.$1, isA<CharacterDataWrapper>());
      expect(result.$1?.data.results.isNotEmpty, true);
      expect(result.$2.isEmpty, true);
    });

    test('Must return a empty list of AssetsModel when http client throws a error', () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params'))).thenThrow(const HttpClientError(
          data: {'message': 'Expired token'}, message: '401 - Authentication invalid', stackTrace: null));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(true);

      when(() => storage.saveCacheMap(key: any(named: 'key'), data: any(named: 'data'))).thenAnswer((_) async => true);

      // act
      final result = await repository.getCharacterListData(GetCharacterListParams(offset: 10));

      // assert
      verifyNever(() => storage.saveCacheMap(key: 'key', data: {}));
      expect(result.$1 == null, true);
      expect(result.$2, equals('401 - Authentication invalid'));
    });

    test('Must return a empty list of AssetsModel when local storage throws a error', () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params')))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(apiResponseJson), statusCode: 200));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(false);

      when(() => storage.readCacheMap(key: any(named: 'key')))
          .thenThrow(const DatasourceError(message: 'Error local storage', stackTrace: null));

      // act
      final result = await repository.getCharacterListData(GetCharacterListParams(offset: 10));

      // assert
      verifyNever(() => httpClient.get(''));
      expect(result.$1 == null, true);
      expect(result.$2, equals('Error local storage'));
    });
  });
}
