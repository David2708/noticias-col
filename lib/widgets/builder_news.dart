import 'package:flutter/material.dart';

import 'package:noticias_app/models/models.dart';
import 'package:noticias_app/services/news_service.dart';
import 'package:noticias_app/utils/utils.dart';
import 'package:provider/provider.dart';
import '../theme/theme_app.dart';

class BuilderNews extends StatelessWidget {

  final List<Article> news;
   
  const BuilderNews({
    Key? key, 
    required this.news,
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () { 
          final navigationModel = Provider.of<NavigationModel>(context, listen: false);
          final newServices = Provider.of<NewsService>(context, listen: false);

          if( navigationModel.paginaActual == 0 ){
            return newServices.getTopHeadLines(true);
          }
          return newServices.getArticlesByCategory(newServices.selectedCategory, true);
         },

        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return _Noticia( noticia: news[index], index: index, ) ;
          },
        ),
      ),
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({
    required this.index,
    required this.noticia,
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Fuente
        _SourceName( source: noticia.source.name, index: index),
        const SizedBox( height: 10 ),
        // Titulo de la noticia
        _Title(title: noticia.title, ),
        const SizedBox( height: 10 ),
        // Imagen de la noticia
        if(noticia.urlToImage != null)
          _Image( urlImage: noticia.urlToImage!, ),
        const SizedBox( height: 15 ),
        // Descripcion de la noticia
        _Description( descripcion: noticia.description, ),
        const SizedBox( height: 5 ),
        // url de la noticia
        _Button( url: noticia.url, ),
        Divider(color: Colors.grey.shade500),
        const SizedBox( height: 10, )
      ],
    );
  }
}

class _Button extends StatelessWidget {

  final String url;

  const _Button({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: const Text('Leer más...'),
        onPressed: (){
          launchUrl( url );
        },
      ),
    );
  }
}

class _Image extends StatelessWidget {

  final String urlImage;

  const _Image({
    required this.urlImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: FadeInImage(
        height: 190,
        width: double.infinity,
        placeholder: const AssetImage('assets/giphy.gif'), 
        image: NetworkImage(urlImage),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Description extends StatelessWidget {

  final String? descripcion;

  const _Description({ this.descripcion});

  @override
  Widget build(BuildContext context) {
    return descripcion == null 
          ? const Text('')
          : Text(descripcion!, style: const TextStyle( fontSize: 16 ),);
  }
}

class _Title extends StatelessWidget {

  final String title;

  const _Title({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle( fontSize: 19 , fontStyle: FontStyle.italic, fontWeight: FontWeight.bold ));
  }
}

class _SourceName extends StatelessWidget {
  final String source;
  final int index;

  const _SourceName({
    required this.index,
    required this.source,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${index + 1}. ', style: TextStyle(color: ThemeApp.primary)),
        Text( source ),
      ],
    );
  }
}