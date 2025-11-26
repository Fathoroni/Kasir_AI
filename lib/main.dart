import 'package:flutter/material.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/dashboard_screen.dart';
import 'src/screens/product_list_screen.dart';
import 'src/screens/product_form_screen.dart';
import 'src/screens/transaction_screen.dart';
import 'src/screens/transaction_history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/products': (context) => const ProductListScreen(),
        '/product_form': (context) => const ProductFormScreen(),
        '/transaction': (context) => const TransactionScreen(),
        '/history': (context) => const TransactionHistoryScreen(),
      },
    );
  }
}
