 
import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {

MoviesProvider() {
  print('MoviesProvider init');

  getOntDisplayMovies();
}

getOntDisplayMovies() async {
  print('getOnDisplayMovies');
}

}