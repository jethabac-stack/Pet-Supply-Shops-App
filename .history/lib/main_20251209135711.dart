import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'firebase_options.dart';

import 'src/screens/admin/dashboard_screen.dart';
import 'src/screens/admin/admin_category_list_screen.dart';
import 'src/screens/admin/admin_category_form_screen.dart';
import 'src/screens/admin/admin_pet_profile_list_screen.dart';
import 'src/screens/admin/admin_pet_profile_form_screen.dart';
import 'src/screens/catalog_screen.dart';
import 'src/screens/cart_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/pet/profile_screen.dart';
import 'src/screens/product_detail_screen.dart';
import 'src/screens/reminders_screen.dart';
import 'src/services/auth_service.dart';
import 'src/services/cart_service.dart';
import 'src/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Supply Shops',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const LoginScreen(),
        '/catalog': (ctx) => const CatalogScreen(),
        '/cart': (ctx) => const CartScreen(),
        '/admin': (ctx) => const AdminDashboardScreen(),
        '/admin/category/list': (ctx) => const AdminCategoryListScreen(),
        '/admin/category/form': (ctx) => const AdminCategoryFormScreen(),
        '/admin/pet-profile/list': (ctx) => const AdminPetProfileListScreen(),
        '/admin/pet-profile/form': (ctx) => const AdminPetProfileFormScreen(),
        '/pet-profile': (ctx) => const PetProfileScreen(),
        '/reminders': (ctx) => const RemindersScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(productId: args?['id']));
        }
        return null;
      },
      builder: (context, child) {
        // Provide simple in-memory services via InheritedWidget-like pattern
        return AuthServiceProvider(
          auth: AuthService(),
          child: CartServiceProvider(
            cart: CartService(),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

// The local provider classes have been removed and replaced with imports from providers.dart
