import 'package:applojavirtualguilherme/common/custom_drawer.dart';
import 'package:applojavirtualguilherme/models/product.dart';
import 'package:applojavirtualguilherme/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/product_list_tile.dart';
import 'components/search_dialog.dart';
import 'product_register.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context, builder: (_) => SearchDialog());

                  if (search != null) {
                    context.read<ProductManager>().search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  context.read<ProductManager>().search = '';
                },
              );
            }
          })
        ],
      ),
      body: Center(
        child: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            final filteredProducts = productManager.filteredProducts;
            return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: filteredProducts.length,
                itemBuilder: (_, index) {
                  return ProductListTile(filteredProducts[index]);
                });
          },
        ),
      ),
      floatingActionButton: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          return FloatingActionButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (_) => ProductRegister(new Product()));
            },
            child: Icon(Icons.add),
            backgroundColor: const Color.fromARGB(255, 46, 139, 87),
          );
        },
      ),
    );
  }
}
