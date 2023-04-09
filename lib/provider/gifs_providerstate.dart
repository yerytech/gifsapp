import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifsapp/model/gifs_model.dart';
import 'package:http/http.dart' as http;

List<Datum> listagif = [];
const String _base = 'api.giphy.com';
const String _apikey = '928LyddVqyJeUyBoMws156QUMC2bl8hJ';
const String _limit = '10';
const String _rating = 'g';

final gifsProvider = FutureProvider<List<Datum>>((ref) async {
  final url = Uri.https(_base, 'v1/gifs/trending',
      {'apikey': _apikey, 'limit': _limit, 'rating': _rating});
  final response = await http.get(url);
  final gifssl = gifphFromJson(response.body);
  listagif = gifssl.data;
  return listagif;
});
