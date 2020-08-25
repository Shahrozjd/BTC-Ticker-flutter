import 'package:http/http.dart' as http;
import 'dart:convert';

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


const coinapiurl =
      'https://rest.coinapi.io/v1/exchangerate';
//https://rest.coinapi.io/v1/exchangerate/BTC/ILC?apikey=B6CB967F-724D-413F-93DF-E0B998098016
String apikey = "B6CB967F-724D-413F-93DF-E0B998098016";
class CoinData {
  //3: Update getCoinData to take the selectedCurrency as an input.
  Future getCoinData(String selectedCurrency) async {
  //4: Update the URL to use the selectedCurrency input.
  String requestURL = '$coinapiurl/BTC/$selectedCurrency?apikey=$apikey';
  print(requestURL);
  http.Response response = await http.get(requestURL);
  if (response.statusCode == 200) {
  var decodedData = jsonDecode(response.body);
  double lastPrice = decodedData['rate'];
  return lastPrice.toStringAsFixed(0);
  } else {
  print(response.statusCode);
  throw 'Problem with the get request';
  }
  }


}
