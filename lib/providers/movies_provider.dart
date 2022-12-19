import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart'; 

class MoviesProvider extends ChangeNotifier {
 
  String _apiKey = dotenv.env['API_KEY'].toString(); 
  String _baseUrl = 'api.themoviedb.org'; //* no hace falta el http ya que Uri lo coloca
  String _language = 'es-ES';
  bool include_adult = true;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies   = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
 
    //print('MoviesProvider init'); 
    getOntDisplayMovies();
    getPopularMovies();
  }
  //                                             opcional
  Future<String> _getJsonData( String endpoint, [int page = 1]) async{
 
  final url = Uri.https(_baseUrl, endpoint, {
        'api_key' : _apiKey,
        'language' : _language,
        'page' : '$page'
        });

   final response = await http.get(url);

   return response.body;
  }

  getOntDisplayMovies() async {

    final jsonData = await _getJsonData('/3/movie/now_playing' ); 
    final nowPlayingResponse = NowPlayingReponse.fromJson(jsonData);
    
    // if(response.statusCode != 200) return print('error');
    //final decodedData = json.decode(response.body) as Map<String, dynamic>;
    //final Map<String, dynamic> decodedData = json.decode(response.body);

    //print(nowPlayingResponse.results[0].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();


  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);  
    final popularResponse = PopularReponse.fromJson(jsonData);
   
    popularMovies = [...popularMovies, ...popularResponse.results];
    //print(popularMovies[0]);
    notifyListeners();


  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if( moviesCast.containsKey( movieId ) ) return moviesCast[movieId]!;

    print('retrieving');

    final jsonData = await _getJsonData('/3/movie/${movieId}/credits');  
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie( String query ) async{

 
  final url = Uri.https(_baseUrl, '3/search/movie', {
        'api_key' : _apiKey,
        'language' : _language, 
        'include_adult': include_adult
        });

  final response = await http.get(url);
  final searchReponse = SearchReponse.fromJson( response.body);

  return searchReponse.results;

  }



}