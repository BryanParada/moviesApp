import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? myTitle;
  final Function onNextPage;
  
  const MovieSlider({
    super.key,
    required this.movies,
    required this.onNextPage,
    this.myTitle
    });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

final ScrollController scrollController = new ScrollController();


//codigo que se ejecuta una vez que es construido
  @override
  void initState() {
    super.initState();
    
    scrollController.addListener(() {

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500)
        widget.onNextPage();

     });

  }

//cuando el widget sera destruido
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        
        if(widget.myTitle != null) 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(widget.myTitle!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded( 
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              // itemBuilder: ( _ , int index){
              //   return _MoviePoster();
              // },
              itemBuilder: (_, int index) => _MoviePoster( movie: widget.movies[index], heroId: '${widget.myTitle}-${widget.movies[index].id}', )),
        ),
      ]),
    );
  }
}

//_ privado
class _MoviePoster extends StatelessWidget {
 
  final Movie movie;
  final String heroId;

  const _MoviePoster({
    super.key,
    required this.movie,
    required this.heroId});

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
        width: 130,
        height: 190,
        //color: Colors.green,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

            

            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context, 'details',
                arguments: movie),
              child: Hero(
                tag: movie.heroId!,
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
