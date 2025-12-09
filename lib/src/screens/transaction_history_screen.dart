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
        'paymentMethod': 'Tunai',
        'items': [
          {'name': 'Nasi Goreng', 'qty': 1, 'price': 15000.0},
          {'name': 'Mie Goreng', 'qty': 1, 'price': 12000.0},
        ],
      },
      {
        'id': 'TX002',
        'date': '26 Nov 2025 11:30',
        'total': 15000.0,
        'paymentMethod': 'E-Wallet',
        'items': [
          {'name': 'Nasi Goreng', 'qty': 1, 'price': 15000.0},
        ],
      },
      {
        'id': 'TX003',
        'date': '25 Nov 2025 18:45',
        'total': 50000.0,
        'paymentMethod': 'Transfer',
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
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  tx['date'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${tx['id']}'),
                    Text(
                      'Metode: ${tx['paymentMethod'] ?? 'Tunai'}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                trailing: Text(
                  'Rp ${tx['total'].toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                          Text('Metode: ${tx['paymentMethod'] ?? 'Tunai'}'),
                          const Divider(),
                          ...((tx['items'] as List).map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Text(
                                'Total',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rp ${tx['total'].toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
