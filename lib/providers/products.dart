import 'package:flutter/foundation.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

// ChangeNotifier usado para notificar lugares que vão usar a classe quando houver mudança na classe
class Products with ChangeNotifier {
  List<Product> _items = dummyproducts;

  // bool _showFavoriteOnly = false;

  // Para não retornarmos a referencia da lista e sim os valores, temos que criar uma nova lista
  // Vamos fazer isso para que quem pegar essa lista, e altera-lá, não vai alterar a lista original.
  List<Product> get items {
    // if (_showFavoriteOnly) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
