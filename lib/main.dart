import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/favorite.dart';
import 'view/login_view.dart';
import 'view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteRecipeAdapter());
  await Hive.openBox<FavoriteRecipe>('favorites');

  // Cek sesi login
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Resep',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // Routing awal berdasarkan status login
      home: isLoggedIn ? const HomeView() : const LoginView(),
    );
  }
}