import 'package:flutter/material.dart';


class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        const Padding (
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
        ),

        SizedBox(height: 5,),

        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20, 
            // itemBuilder: ( _ , int index){
            //   return _MoviePoster();
            // },
            itemBuilder: ( _ , int index) => _MoviePoster()
          ),
        ),

      ]),
    );
  }
}

//_ privado
class _MoviePoster extends StatelessWidget {
  const _MoviePoster({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: EdgeInsets.symmetric( horizontal: 10),
      child: Column(
        children: [

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
              child: ClipRRect(//para borderradius
              borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://via.placeholder.com/300x400'),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover
                  ),
              ),
            ),


              Text(
                'Star Wars: El retorno de el nuevo jedi silvestre de monte cristo',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                )
        ],)
    );
  }
}