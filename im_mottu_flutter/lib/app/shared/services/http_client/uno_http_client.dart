import 'package:uno/uno.dart';

import '../../../../env.dart';
import '../../constants/constants.dart';
import '../../errors/http_client_error.dart';
import 'http_response.dart';
import 'i_http_client.dart';
import 'typedefs.dart';

class UnoHttpClient implements IHttpClient {
  final Uno uno;

  UnoHttpClient(this.uno) {
    uno.interceptors.request.use(
      (request) async {
        request = addApiKey(request);
        return request;
      },
      onError: (error) async {
        return error;
      },
    );
    uno.interceptors.response.use(
      (p0) => p0,
      onError: (error) async {
        return error;
      },
    );
  }

  Request addApiKey(Request request) {
    var uri = request.uri;

    final dateTime = DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch.toString();

    final newQueryParameters = Map<String, String>.from(uri.queryParameters)
      ..addAll({
        'ts': dateTime,
        'apikey': Env.apiKey,
        'hash': Env.apiHashKey(timeStamp: dateTime),
      });

    uri = uri.replace(queryParameters: newQueryParameters);

    request = request.copyWith(uri: uri);
    return request;
  }

  @override
  AsyncResponse get(
    String url, {
    data,
    HttpHeadersAnotattion headers = const {
      'accept': 'text/plain',
      'Content-Type': 'application/json',
    },
    Map<String, String> params = const {},
  }) async {
    try {
      var url0 = url;
      if (!url0.startsWith('http')) {
        url0 = kBaseUrl + url;
      }
      final result = await uno.get(
        url0,
        headers: headers,
        params: params,
      );

      return HttpResponse(
        statusCode: result.status,
        data: result.data,
      );
    } on UnoError catch (e) {
      throw HttpClientError(
        message: e.message,
        data: e.data,
        stackTrace: e.stackTrace,
      );
    }
  }
}
