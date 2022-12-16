import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  String _apiKey = '840895056f195254dea7bdbadd6075a6';
  String _baseUrl = 'api.themoviedb.org'; //* no hace falta el http ya que Uri lo coloca
  String _language = 'es-ES';

  MoviesProvider() {
 
    print('MoviesProvider init');

    getOntDisplayMovies();
  }

  getOntDisplayMovies() async {
    //print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : '1'
      });

    final response = await http.get(url);
    // if(response.statusCode != 200) return print('error');
    //final decodedData = json.decode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> decodedData = json.decode(response.body);
    print(decodedData['results']);

  }

}