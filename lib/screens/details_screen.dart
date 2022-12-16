import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Cambiar luego por una instancia de movie

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return const Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                _PosterAndTitle(),
              ]),
              )
          ],
        )
      );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

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
          color: Colors.black12,
          child: const Text(
            'movie.title',
            style: TextStyle( fontSize: 16),
            )
        ),

        background: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage('https://via.placeholder.com/500x300'),
            fit: BoxFit.cover),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150

            )
          ),

          const SizedBox( width: 20, ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headline5, maxLines: 2,),
              Text('movie.originalTitle', style: textTheme.subtitle1, maxLines: 1,),

              Row(children: [
                Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                 SizedBox( width: 5, ),
                Text('movie.voteAverage', style: textTheme.caption,)
              ],)
            ],
          )
        ],
      )
    );
  }
}