import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) { 

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie; 

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie: movie),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                _PosterAndTitle(movie: movie),
                _Overview(movie: movie), 
                CastingCards(movieId: movie.id, ),
              ]),
              )
          ],
        )
      );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({
    super.key,
    required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom:10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle( fontSize: 16),
            textAlign: TextAlign.center,
            )
        ),

        background: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;
  
  const _PosterAndTitle({
   super.key,
   required this.movie});

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg), //'https://via.placeholder.com/200x300'
              height: 150

            )
          ),

          const SizedBox( width: 20, ),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movie.title, style: textTheme.headline5, maxLines: 2,) 
           
                ,
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1,),
          
                Row(children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                  SizedBox( width: 5, ),
                  Text('${movie.voteAverage}', style: textTheme.caption,)
                ],)
              ],
            ),
          )
        ],
      )
    );
  }
}


class _Overview extends StatelessWidget {
  
  final Movie movie;

  const _Overview({
    super.key,
   required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: 
      Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1
      ),
    );
  }
}

