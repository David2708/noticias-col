import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:noticias_app/models/models.dart';
import 'package:noticias_app/screens/screens.dart';

class TabsScreen extends StatelessWidget {
   
  const TabsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => NavigationModel(),
      child: const Scaffold(
        //Pantallas
        body: _Screens(),
        //Botones de Navegación
        bottomNavigationBar: _Navegacion()
      ),

    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        
        Tab1Screen(),

        Tab2Screen()

      ],
    );
  }
}


//Botones de Navegacion
class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.paginaActual,
      onTap: (value) => navigationModel.paginaActual =  value,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: 'Para ti'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados'
        )
      ],

    );
  }
}

