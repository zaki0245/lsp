import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp/CashFlowPage.dart';

class PengeluaranPage extends StatefulWidget {
  final List<Transaction> transactions;

  PengeluaranPage({required this.transactions});

  @override
  _PengeluaranPageState createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Pengeluaran',
          style: TextStyle(color: Colors.black), // Warna header hitam
        ),
        backgroundColor: Colors.transparent, // Header transparan
        elevation: 0, // Hilangkan bayangan header
        automaticallyImplyLeading: false, // Hilangkan tombol panah kembali
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Tambah Pengeluaran',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  enabled: false,
                  controller: TextEditingController(
                    text: DateFormat.yMMMd().format(selectedDate),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal Uang',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan fungsi untuk mereset inputan
                      amountController.clear();
                      descriptionController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Ganti warna latar belakang
                    ),
                    child: Text('Reset'),
                  ),
                ),
                SizedBox(width: 10), // Tambahkan jarak horizontal
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan fungsi untuk menyimpan data pengeluaran
                      final amount =
                          double.tryParse(amountController.text) ?? 0.0;
                      final description = descriptionController.text;
                      widget.transactions.add(Transaction(
                        date: DateFormat.yMMMd().format(selectedDate),
                        amount: amount,
                        description: description,
                        isExpense: true,
                      ));
                      Navigator.pop(context, amount);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Ganti warna latar belakang
                    ),
                    child: Text('Simpan'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Tambahkan jarak vertikal
            ElevatedButton(
              onPressed: () {
                // Tambahkan fungsi untuk kembali ke halaman home
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
