import 'package:flutter/widgets.dart';

import 'services/auth_service.dart';
import 'services/cart_service.dart';

class AuthServiceProvider extends InheritedWidget {
  final AuthService auth;

  const AuthServiceProvider({required this.auth, required super.child, super.key});

  static AuthService of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AuthServiceProvider>();
    return provider!.auth;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class CartServiceProvider extends InheritedWidget {
  final CartService cart;

  const CartServiceProvider({required this.cart, required super.child, super.key});

  static CartService of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<CartServiceProvider>();
    return provider!.cart;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
