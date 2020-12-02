import 'package:applojavirtualguilherme/models/cart_manager.dart';
import 'package:applojavirtualguilherme/models/product_manager.dart';
import 'package:applojavirtualguilherme/models/user_manager.dart';
import 'package:applojavirtualguilherme/screens/BaseScreen.dart';
import 'package:applojavirtualguilherme/screens/login/screen_login.dart';
import 'package:applojavirtualguilherme/screens/product/product_screen.dart';
import 'package:applojavirtualguilherme/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create:(_) => UserManager(),
        lazy: false,
        ),
       //Provider(
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        /*Provider(
          create: (_) => CartManager(),
          lazy: false,
        ),*/
      ],
      //return MultiProvider(

      child: MaterialApp(
        title: 'Warriors Path',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          primaryColor: const Color.fromARGB(255, 46, 139, 87),
          scaffoldBackgroundColor: const Color.fromARGB(255, 60, 179, 113),
          //primaryColor: const Color.fromARGB(255, 140, 23, 23),
          // scaffoldBackgroundColor: const Color.fromARGB(255, 255, 0, 0),
          //primaryColor: const Color.fromARGB(255, 4, 125, 141),
          //scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //appBarTheme: const AppBarTheme(
          //elevation: 0
          //),
        ),
        //home: Container(),
        home: BaseScreen(),
        initialRoute: '/base',
          onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                      settings.arguments as Product
                  )
              );
            case '/base':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
              );
          }
        }
      ),
    );
  }
}
