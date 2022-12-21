import 'dart:async'; 

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart'; 

class MoviesProvider extends ChangeNotifier {
 
  final String _apiKey = dotenv.env['API_KEY'].toString(); 
  final String _baseUrl = 'api.themoviedb.org'; //* no hace falta el http ya que Uri lo coloca
  final String _language = 'es-MX';
  bool includeAdult = true;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies   = [];

  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Result>> trailers = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500 ), 
    );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
 
    //print('MoviesProvider init'); 
    getOnDisplayMovies();
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

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('/3/movie/now_playing' ); 
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    
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
    final popularResponse = PopularResponse.fromJson(jsonData);
   
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
      'query': query
            });

      final response = await http.get(url);
      final searchResponse = SearchResponse.fromJson( response.body);

      return searchResponse.results;

  }

  void getSuggestionByQuery( String searchTerm){

    debouncer.value = '';
    debouncer.onValue = ( value ) async {

      print('tenemos valor a buscar: $value');
      final results = await this.searchMovie(value);
      this._suggestionStreamController.add( results );
    };

    final timer = Timer.periodic(Duration( milliseconds: 300), ( _ ) {

      debouncer.value = searchTerm;

     });

    Future.delayed(Duration( milliseconds: 301) ).then(( _ ) => timer.cancel());
  }

  getTrailerMovie(int movieId) async {
  
    final jsonData = await _getJsonData('/3/movie/${movieId}/videos' );  
    final trailerResponse = TrailerReponse.fromJson( jsonData );
 
    if (trailerResponse.results.isEmpty) { 
      return null; 
    }

    trailers[movieId] = trailerResponse.results; 
     
    return trailerResponse.results[0].key;


  }



}