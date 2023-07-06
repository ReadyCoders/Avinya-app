import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyB03ftPXa1YmmzySq9U1MkeomMbBD1KGJ0',
        appId: '1:458259510432:web:5690cc754ddcfbef2445c5',
        messagingSenderId: '458259510432',
        projectId: 'avinya-17d9d',
        authDomain: 'avinya-17d9d.firebaseapp.com',
        storageBucket: 'avinya-17d9d.appspot.com',
        measurementId: 'G-B2E744C7J7',
      )
    );
  }
  else{
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBAkl2DZCkbHxs4fwFGK11VVfc61PFG68g',
        appId: '1:458259510432:android:0735c09c19a850622445c5',
        messagingSenderId: '458259510432',
        projectId: 'avinya-17d9d',
        storageBucket: 'avinya-17d9d.appspot.com',
      )
    );
  }
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avinya App',
      theme: ThemeData(
        useMaterial3: true,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: SplashScreen(),
    );
  }
}
