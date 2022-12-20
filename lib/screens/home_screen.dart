import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});
 
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);
    print(moviesProvider.popularMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon( Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
            )
        ],
      ),
      body: SingleChildScrollView(

          child: Column(
            children: [

              //Tarjetas principales
              CardSwiper( movies: moviesProvider.onDisplayMovies ),  

              // Slider de peliculas
              MovieSlider(
                 movies: moviesProvider.popularMovies, //populares
                 myTitle: 'Populares',//opcional
                 onNextPage: () => moviesProvider.getPopularMovies(),
              ), 
              // MovieSlider(
              //    movies: moviesProvider.popularMovies, //populares
              //    myTitle: 'Próximos Estrenos',//opcional
              //    onNextPage: () => moviesProvider.getPopularMovies(),
              // ), 
            ],
          )
          
      )
    );
  }
}