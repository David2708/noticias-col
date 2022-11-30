
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias_app/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService extends ChangeNotifier{

  final _baseUrl = 'newsapi.org';
  final _apikey = 'e14cf4e72ab5421f8658f2860094bce0';
  final _country = 'co';
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Article> headlines = [];

  Map< String, List<Article> > mapCategoriesArticles = {};

  List<Category> listCategories = [
    Category(FontAwesomeIcons.businessTime, 'Negocios', 'business'),
    Category(FontAwesomeIcons.tv, 'Entretenimiento', 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'General', 'general'),
    Category(FontAwesomeIcons.notesMedical, 'Salud', 'health'),
    Category(FontAwesomeIcons.flask, 'Ciencia', 'science'),
    Category(FontAwesomeIcons.futbol, 'Deportes', 'sports'),
    Category(FontAwesomeIcons.memory, 'Tecnología', 'technology'),
  ];

  NewsService(){
    getTopHeadLines();

    for (var item in listCategories) { 
      mapCategoriesArticles[item.nameUs] = [];
     }

    getArticlesByCategory( _selectedCategory );
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory( String valor ) {
    _selectedCategory = valor;

    _isLoading = true;
    getArticlesByCategory(_selectedCategory);
    notifyListeners();
  }

  get getArticulosCategoriaSelecionada => mapCategoriesArticles[selectedCategory];

  get isloading => _isLoading;

  getTopHeadLines( [bool refresh = false] ) async {
    final url = Uri.https( _baseUrl, 'v2/top-headlines',{
      'country' : _country,
      'apiKey' : _apikey,
    } );

    final response = await http.get(url);
    final newResponse = NewsResponse.fromJson(response.body);

    if(refresh == false){
      headlines.addAll(newResponse.articles);
    }else{
      headlines.clear();
      headlines.addAll(newResponse.articles);
    }
    
    _isLoading = false;
    notifyListeners();
  }

  getArticlesByCategory( String category, [ bool refresh = false] ) async {

    if ( mapCategoriesArticles[category]!.isNotEmpty && refresh == false ) {
      _isLoading = false;
      notifyListeners();
      return mapCategoriesArticles[category];
    }

    final url = Uri.https( _baseUrl, 'v2/top-headlines',{
      'country' : _country,
      'category': category,
      'apiKey' : _apikey,
    } );

    final response = await http.get(url);

    final newResponse =  NewsResponse.fromJson(response.body);

    if(refresh == false){
      mapCategoriesArticles[category]!.addAll(newResponse.articles);
    } else{
      mapCategoriesArticles[category] = [];
      mapCategoriesArticles[category]!.addAll(newResponse.articles);
    }

    _isLoading = false;
    notifyListeners();

  }

  

}