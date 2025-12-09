import 'package:flutter/material.dart';

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
              _DashboardButton(
                icon: Icons.shopping_cart,
                text: 'Transaksi Baru',
                onPressed: () {
                  Navigator.pushNamed(context, '/transaction');
                },
              ),
              const SizedBox(height: 16),
              _DashboardButton(
                icon: Icons.list,
                text: 'Daftar Produk',
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
              const SizedBox(height: 16),
              _DashboardButton(
                icon: Icons.history,
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

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const _DashboardButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
