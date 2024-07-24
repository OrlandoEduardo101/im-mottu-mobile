import 'typedefs.dart';

abstract class IHttpClient {
  AsyncResponse get(
    String url, {
    dynamic data,
    HttpHeadersAnotattion headers = const {},
    Map<String, String> params = const {},
  });
}
