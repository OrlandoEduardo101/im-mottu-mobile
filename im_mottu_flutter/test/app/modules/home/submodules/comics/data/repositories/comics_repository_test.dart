import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/data/repositories/comics_repository.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/models/comic_item_detail_model.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/params/get_comics_details_params.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/repositories/i_comics_repository.dart';
import 'package:im_mottu_flutter/app/shared/errors/datasource_error.dart';
import 'package:im_mottu_flutter/app/shared/errors/http_client_error.dart';
import 'package:im_mottu_flutter/app/shared/services/analytics/crashalytics_service.dart';
import 'package:im_mottu_flutter/app/shared/services/connectivity/check_connectivity_service.dart';
import 'package:im_mottu_flutter/app/shared/services/http_client/http_response.dart';
import 'package:im_mottu_flutter/app/shared/services/http_client/i_http_client.dart';
import 'package:im_mottu_flutter/app/shared/services/local_storage/shared_preferences_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../comic_data.dart';

class HttpClientMock extends Mock implements IHttpClient {}

class CheckConnectivityMock extends Mock implements ICheckConnectivityService {}

class StorageMock extends Mock implements ISharedPreferencesService {}

class CrashAlyticsMock extends Mock implements ICrashlyticsService {}

class StackTraceFake extends Fake implements StackTrace {}

main() {
  late final IComicsRepository repository;
  late final IHttpClient httpClient;
  late final ICheckConnectivityService connectivityService;
  late final ISharedPreferencesService storage;
  late final ICrashlyticsService crashlyticsService;

  setUpAll(() {
    httpClient = HttpClientMock();
    connectivityService = CheckConnectivityMock();
    storage = StorageMock();
    crashlyticsService = CrashAlyticsMock();
    repository = ComicsRepository(httpClient, connectivityService, storage, crashlyticsService);

    registerFallbackValue(StackTraceFake());

    when(() => crashlyticsService.recordError(any(), any())).thenAnswer((_) async => true);
  });

  group('Get character list', () {
    test('Must return a ComicItemDetailModel when http client return response with success', () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params')))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(apiComicFullResponseJson), statusCode: 200));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(true);

      when(() => storage.saveCacheMap(key: any(named: 'key'), data: any(named: 'data'))).thenAnswer((_) async => true);

      // act
      final result = await repository
          .getComicDetails(GetComicsDetailsParams(resourceUrl: 'http://gateway.marvel.com/v1/public/comics/21366'));

      // assert
      expect(result.$1, isA<ComicItemDetailModel>());
      expect(result.$1?.characters?.items?.isNotEmpty, true);
      expect(result.$2.isEmpty, true);
    });

    test('Must return a ComicItemDetailModel when local storage return response with success', () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params')))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(apiComicFullResponseJson), statusCode: 200));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(false);

      when(() => storage.readCacheMap(
            key: any(named: 'key'),
          )).thenAnswer((_) async => jsonDecode(apiComicFullResponseJson));

      // act
      final result = await repository
          .getComicDetails(GetComicsDetailsParams(resourceUrl: 'http://gateway.marvel.com/v1/public/comics/21366'));

      // assert
      verifyNever(() => httpClient.get(''));
      expect(result.$1, isA<ComicItemDetailModel>());
      expect(result.$1?.characters?.items?.isNotEmpty, true);
      expect(result.$2.isEmpty, true);
    });

    test('Must return a empty list of AssetsModel when http client throws a error', () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params'))).thenThrow(const HttpClientError(
          data: {'message': 'Expired token'}, message: '401 - Authentication invalid', stackTrace: null));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(true);

      when(() => storage.saveCacheMap(key: any(named: 'key'), data: any(named: 'data'))).thenAnswer((_) async => true);

      // act
      final result = await repository
          .getComicDetails(GetComicsDetailsParams(resourceUrl: 'http://gateway.marvel.com/v1/public/comics/21366'));

      // assert
      verifyNever(() => storage.saveCacheMap(key: 'key', data: {}));
      expect(result.$1 == null, true);
      expect(result.$2, equals('401 - Authentication invalid'));
    });

    test('Must return a empty list of AssetsModel when local storage throws a error', () async {
      // mock
      when(() => httpClient.get(any(), params: any(named: 'params')))
          .thenAnswer((_) async => HttpResponse(data: jsonDecode(apiComicFullResponseJson), statusCode: 200));

      when(() => connectivityService.checkConnectivitySnapshot).thenReturn(false);

      when(() => storage.readCacheMap(key: any(named: 'key')))
          .thenThrow(const DatasourceError(message: 'Error local storage', stackTrace: null));

      // act
      final result = await repository
          .getComicDetails(GetComicsDetailsParams(resourceUrl: 'http://gateway.marvel.com/v1/public/comics/21366'));

      // assert
      verifyNever(() => httpClient.get(''));
      expect(result.$1 == null, true);
      expect(result.$2, equals('Error local storage'));
    });
  });
}
