import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart'; 

void main() {
  //*se utiliza appState para obligar a que sea lo primero que se inicialice
  runApp(const AppState()); //MyApp
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false, )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home'   :( _ ) => HomeScreen(),
        'details':( _ ) => DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent
        )
      ),
    );   
  }
}

 