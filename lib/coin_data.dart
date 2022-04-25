import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '75EAB492-D9C6-4CCE-AC8F-ACC8ED5EF472';
String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  late Map data;
  late String price;

  Future<String> getCoinData(String selectedCurrency) async {
    String newUrl = '$url$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(Uri.parse(newUrl));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      price = data['rate'].toString();
      return price;
    } else {
      throw 'Problem Connecting';
    }
  }
}
