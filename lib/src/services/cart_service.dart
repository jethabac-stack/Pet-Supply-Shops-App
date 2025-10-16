import '../models/product.dart';

class CartService {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  void add(Product p) {
    _items.add(p);
  }

  void remove(Product p) {
    _items.remove(p);
  }

  void clear() {
    _items.clear();
  }

  double get total => _items.fold(0.0, (t, e) => t + e.price);
}
