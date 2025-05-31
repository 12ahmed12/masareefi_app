import '../../../../core/networking/api_client.dart';

class CurrencyApi {
  final ApiClient client;
  CurrencyApi(this.client);

  Future<double?> fetchExchangeRate(
      {String from = "EGP", String to = "USD"}) async {
    try {
      final response =
          await client.dio.get('https://open.er-api.com/v6/latest/$from');
      return response.data["rates"][to];
    } catch (_) {
      return null;
    }
  }
}
