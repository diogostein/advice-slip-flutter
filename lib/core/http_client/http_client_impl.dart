import 'package:advice_slip/core/http_client/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements HttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url) async {
    try {
      final response = await client.get(Uri.parse(url));

      return HttpResponse(statusCode: response.statusCode, data: response.body);
    } catch (e) {
      return HttpResponse(statusCode: 500, data: null);
    }
  }
}
