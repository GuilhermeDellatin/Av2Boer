import 'package:applojavirtualguilherme/common/custom_drawer.dart';
import 'package:applojavirtualguilherme/models/page_manager.dart';
import 'package:applojavirtualguilherme/screens/login/screen_login.dart';
import 'package:applojavirtualguilherme/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          /*Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Menu"),
            ),
          ),*/
          //LoginScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Tela1"),
            ),
          ),

          ProductsScreen(),

          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Tela3"),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Tela4"),
            ),
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
