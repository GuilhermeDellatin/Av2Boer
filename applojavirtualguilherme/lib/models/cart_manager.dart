import 'package:applojavirtualguilherme/models/product.dart';
import 'cart_product.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
  }
}
