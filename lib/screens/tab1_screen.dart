import 'package:flutter/material.dart';
import 'package:noticias_app/services/news_service.dart';
import 'package:noticias_app/widgets/builder_news.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatelessWidget {
   
  const Tab1Screen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

  final newService = Provider.of<NewsService>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: newService.isloading 
               ? const Center(child: CircularProgressIndicator())
               : BuilderNews(news: newService.getArticulosCategoriaSelecionada),
        ),
      )
    );
  }
}