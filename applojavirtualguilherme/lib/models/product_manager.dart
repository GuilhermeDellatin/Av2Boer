import 'package:applojavirtualguilherme/helpers/firebase_errors.dart';
import 'package:applojavirtualguilherme/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    //acessa o método private da classe para ler todos os produtos cadastrados
    loadAllProducts();
  }

  bool _loading = false; //Transformando em private

  bool get loading => _loading; //Dando get para retornar loading

  set loading(bool value) {
    _loading = value;

    notifyListeners(); //exibir notificações por meio do loading
  }

  //instancia o firebase firestore
  final Firestore firestore = Firestore.instance;

  //List<Product> _allProducts = [];

  List<Product> allProducts = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Future<void> loadAllProducts() async {
    //consulta na coleção de products trazendo os produtos
    final QuerySnapshot snapProducts =
        await firestore.collection('products').getDocuments();

    //List<Product> _allProducts = [];
    //List<Product> allProducts = [];

    //_allProducts = snapProducts.documents.map((d) => Product.fromDocument(d)).toList();
    allProducts =
        snapProducts.documents.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  Future<void> signUp(
      {Product product, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      await product.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> updateProduct(
      {Product product, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      await product.updateData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> removeProduct(
      {Product product, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      await product.removeData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }
}
