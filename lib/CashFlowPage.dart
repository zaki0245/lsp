import 'package:flutter/material.dart';

class Transaction {
  final String date;
  final double amount;
  final String description;
  final bool isExpense; // true untuk pengeluaran, false untuk pemasukan

  Transaction(
      {required this.date,
      required this.amount,
      required this.description,
      required this.isExpense});
}

class CashFlowPage extends StatelessWidget {
  final List<Transaction> transactions;

  CashFlowPage({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Detail Cash Flow',
          style: TextStyle(color: Colors.black), // Warna header hitam
        ),
        backgroundColor: Colors.transparent, // Header transparan
        elevation: 0, // Hilangkan bayangan header
        automaticallyImplyLeading: false, // Hilangkan tombol panah kembali
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          String transactionType = transaction.isExpense ? "[ - ]" : "[ + ]";

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    '$transactionType Rp ${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.description}',
                    style: TextStyle(),
                  ),
                  Text(
                    '${transaction.date}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors
                            .grey), // Menghapus opacity dan mengganti warna ke abu-abu
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (transaction.isExpense)
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.red,
                      size: 48,
                    )
                  else
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                      size: 48,
                    ),
                ],
              ),
              contentPadding: EdgeInsets.all(8.0),
              tileColor: Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan fungsi untuk kembali ke halaman utama
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
