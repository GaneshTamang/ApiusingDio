import 'package:catapi_1/screens/breed_screen.dart';
import 'package:catapi_1/screens/vote_cat_screen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      title: 'RestApiWithProvider',
      initialRoute: '/',
      routes: {
        //passing widget context on route homepage
        '/': (context) => const VoteCatScreen(),
        '/breedPage': (context) => const BreedScreen(),
        '/voteCatScreen': (context) => const VoteCatScreen(),
        // '/secondPage': (context) => const SecondPage(),
      },
    );
  }
}
