import 'package:flutter/material.dart';


class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.red,
      child: Column(
        children: [
        
        const Padding (
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
        ),

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
      color: Colors.green,
      margin: EdgeInsets.symmetric( horizontal: 10, vertical: 10)
    );
  }
}