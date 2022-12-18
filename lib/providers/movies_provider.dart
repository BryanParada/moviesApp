import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
 
  String _apiKey = dotenv.env['API_KEY'].toString(); 
  String _baseUrl = 'api.themoviedb.org'; //* no hace falta el http ya que Uri lo coloca
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

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
    final nowPlayingResponse = NowPlayingReponse.fromJson(response.body);
    
    // if(response.statusCode != 200) return print('error');
    //final decodedData = json.decode(response.body) as Map<String, dynamic>;
    //final Map<String, dynamic> decodedData = json.decode(response.body);

    //print(nowPlayingResponse.results[0].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();


  }

}