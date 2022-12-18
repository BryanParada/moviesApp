import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    super.key,
    required this.movies});
 
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
 
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      //color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ( _ , int index){

          final movie = movies[index];
          //print(movie.fullPosterImg);

          return GestureDetector(//permite añadir onTap
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(//pora añadir border radius
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover //<- para adaptar imagen al tamaño que tiene el contenedor padre
                ),
            ),
          );
        },
        ),
    );
  }
}