import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimaryButton(
                text: 'Transaksi Baru',
                onPressed: () {
                  Navigator.pushNamed(context, '/transaction');
                },
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'Daftar Produk',
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'Riwayat Transaksi',
                onPressed: () {
                  Navigator.pushNamed(context, '/transactions/history');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
