import 'package:flutter/material.dart';
import 'package:lsp/CashFlowPage.dart';
import 'package:lsp/login.dart';
import 'package:lsp/pemasukan.dart';
import 'package:lsp/pengeluaran.dart';
import 'package:lsp/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double pengeluaran = 0.0; // Nilai pengeluaran default
  double pemasukan = 0.0; // Nilai pemasukan default

  List<Transaction> transactions = []; // List transaksi

  @override
  void initState() {
    super.initState();
    _loadTransactions(); // Memuat data pengeluaran dan pemasukan saat halaman dimuat
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();

    // Memuat data pengeluaran dari SharedPreferences, jika tidak ada, gunakan nilai default 0.0
    pengeluaran = prefs.getDouble('pengeluaran') ?? 0.0;

    // Memuat data pemasukan dari SharedPreferences, jika tidak ada, gunakan nilai default 0.0
    pemasukan = prefs.getDouble('pemasukan') ?? 0.0;

    // Load data transaksi dari database seperti yang telah Anda implementasikan sebelumnya
    // transactions = await loadTransactionsFromDatabase();
  }

  Future<void> _updateAndSaveTotals() async {
    final prefs = await SharedPreferences.getInstance();

    // Simpan nilai pengeluaran ke SharedPreferences
    prefs.setDouble('pengeluaran', pengeluaran);

    // Simpan nilai pemasukan ke SharedPreferences
    prefs.setDouble('pemasukan', pemasukan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.black), // Warna header hitam
        ),
        backgroundColor: Colors.transparent, // Header transparan
        elevation: 0, // Hilangkan bayangan header
        automaticallyImplyLeading: false, // Hilangkan tombol panah kembali
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Rangkuman Bulan Ini',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pengeluaran : ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red, // Warna merah untuk pengeluaran
                ),
              ),
              Text(
                'Rp. ${pengeluaran.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red, // Warna merah untuk pengeluaran
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pemasukan   : ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green, // Warna hijau untuk pemasukan
                ),
              ),
              Text(
                'Rp. ${pemasukan.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green, // Warna hijau untuk pemasukan
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: <Widget>[
              buildButton(
                'Pengeluaran',
                'Kelola pengeluaranmu di sini',
                'images/pengeluaran.png',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PengeluaranPage(transactions: transactions),
                    ),
                  ).then((value) {
                    if (value != null && value is double) {
                      setState(() {
                        pengeluaran += value;
                      });
                      _updateAndSaveTotals(); // Simpan nilai pengeluaran saat berubah
                    }
                  });
                },
              ),
              buildButton(
                'Pemasukan',
                'Catat pemasukanmu di sini',
                'images/pemasukan.png',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PemasukanPage(transactions: transactions),
                    ),
                  ).then((value) {
                    if (value != null && value is double) {
                      setState(() {
                        pemasukan += value;
                      });
                      _updateAndSaveTotals(); // Simpan nilai pemasukan saat berubah
                    }
                  });
                },
              ),
              buildButton(
                'Detail Cash Flow',
                'Lihat riwayat transaksimu',
                'images/cashflow.png',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CashFlowPage(transactions: transactions),
                    ),
                  );
                },
              ),
              buildButton(
                'Pengaturan',
                'Pengaturan aplikasi',
                'images/setting.png',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(
    String title,
    String description,
    String imagePath,
    VoidCallback onPressed,
  ) {
    return Transform.scale(
      scale: 1.5, // Ganti dengan faktor skala yang sesuai
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onPressed,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 64,
                  height: 64,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
