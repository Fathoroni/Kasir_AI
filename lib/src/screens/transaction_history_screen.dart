import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<Map<String, dynamic>> transactions = [
      {
        'id': 'TX001',
        'date': '26 Nov 2025 10:00',
        'total': 27000.0,
        'items': [
          {'name': 'Nasi Goreng', 'qty': 1, 'price': 15000.0},
          {'name': 'Mie Goreng', 'qty': 1, 'price': 12000.0},
        ],
      },
      {
        'id': 'TX002',
        'date': '26 Nov 2025 11:30',
        'total': 15000.0,
        'items': [
          {'name': 'Nasi Goreng', 'qty': 1, 'price': 15000.0},
        ],
      },
      {
        'id': 'TX003',
        'date': '25 Nov 2025 18:45',
        'total': 50000.0,
        'items': [
          {'name': 'Nasi Goreng', 'qty': 2, 'price': 15000.0},
          {'name': 'Es Teh Manis', 'qty': 4, 'price': 5000.0},
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            leading: const Icon(Icons.receipt_long, color: Colors.indigo),
            title: Text(tx['date']),
            subtitle: Text('ID: ${tx['id']}'),
            trailing: Text(
              'Rp ${tx['total'].toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Detail Transaksi ${tx['id']}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanggal: ${tx['date']}'),
                      const Divider(),
                      ...((tx['items'] as List).map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${item['qty']}x ${item['name']}'),
                              Text(
                                'Rp ${(item['price'] * item['qty']).toStringAsFixed(0)}',
                              ),
                            ],
                          ),
                        ),
                      )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rp ${tx['total'].toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
