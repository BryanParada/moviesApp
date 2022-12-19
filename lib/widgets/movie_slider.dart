import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? myTitle;

  
  const MovieSlider({
    super.key,
    required this.movies,
    this.myTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        
        if(myTitle != null) 
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(myTitle!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded( 
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              // itemBuilder: ( _ , int index){
              //   return _MoviePoster();
              // },
              itemBuilder: (_, int index) => _MoviePoster( movie: movies[index] )),
        ),
      ]),
    );
  }
}

//_ privado
class _MoviePoster extends StatelessWidget {
 
  final Movie movie;

  const _MoviePoster({
    super.key,
    required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 190,
        //color: Colors.green,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

            

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: 'movie-instance'),
              child: ClipRRect(
                //para borderradius
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),  
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover),
              ),
            ),
             Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
