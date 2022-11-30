

import 'package:flutter/cupertino.dart';

class NavigationModel extends ChangeNotifier{

  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual( int value ){
    _paginaActual = value;

    _pageController.animateToPage(value, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => _pageController;

}