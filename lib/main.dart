import 'package:flutter/material.dart';

import 'package:noticias_app/screens/screens.dart';
import 'package:noticias_app/services/news_service.dart';
import 'package:noticias_app/theme/theme_app.dart';
import 'package:provider/provider.dart';


void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsService(),),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const TabsScreen(),
      theme: ThemeApp.tema,
    );
  }
}