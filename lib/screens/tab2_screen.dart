import 'package:flutter/material.dart';
import 'package:noticias_app/models/category_model.dart';
import 'package:noticias_app/services/news_service.dart';
import 'package:noticias_app/theme/theme_app.dart';
import 'package:noticias_app/widgets/builder_news.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
   
  const Tab2Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children:  [
            const _ListCategories(),

            const SizedBox(height:20),

            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: newService.isloading 
               ? const Center(child: CircularProgressIndicator())
               : BuilderNews(news: newService.getArticulosCategoriaSelecionada),
            ))

          ],
        )
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {


  const _ListCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).listCategories;
    

    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 60,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _Category(category: categories[index]);
        },
      ),
    );
  }
}


class _Category extends StatelessWidget {
  const _Category({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    
    final seletedCategoria = Provider.of<NewsService>(context).selectedCategory;

    return GestureDetector(
      
      onTap: () async {
              final newService = Provider.of<NewsService>(context, listen: false);
              newService.selectedCategory = category.nameUs;
      },
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: Icon( 
                category.icon, 
                size: 30, 
                color: ( seletedCategoria == category.nameUs )
                        ? ThemeApp.primary
                        : Colors.grey.shade500,
                
              )
          ),
          const SizedBox( height: 10 ),
          Text( 
            category.nameEs, 
            style: TextStyle( 
              fontSize: 15, 
              color: (seletedCategoria == category.nameUs)
                    ? ThemeApp.primary
                    : Colors.grey.shade500,
            ) 
          )
        ],
      ),
    );
  }
}