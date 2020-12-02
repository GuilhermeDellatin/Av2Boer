import 'package:applojavirtualguilherme/models/product_manager.dart';
import 'package:applojavirtualguilherme/screens/products/product_register.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:applojavirtualguilherme/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(builder: (_, productManager, __) {
            return IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                await showDialog<String>(
                    context: context,
                    builder: (_) => ProductRegister(product));
                Navigator.of(context).pop();
              },
            );
          }),
          Consumer<ProductManager>(builder: (_, productManager, __) {
            return IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await productManager.removeProduct(
                    product: product,
                    onSuccess: () {
                      productManager.loadAllProducts();
                      Navigator.of(context).pop();
                    },
                    onFail: (e) {
                      SnackBar(
                        content: Text('Falha ao cadastrar Produto: $e'),
                        backgroundColor: Colors.red,
                      );
                    });
              },
            );
          })
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: product.imagens.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'A partir de',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  'R\$ 19.99',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
