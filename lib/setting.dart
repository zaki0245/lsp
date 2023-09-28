import 'package:flutter/material.dart';
import 'package:lsp/user_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool showPassword = false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(color: Colors.black), // Warna header hitam
        ),
        backgroundColor: Colors.transparent, // Header transparan
        elevation: 0, // Hilangkan bayangan header
        automaticallyImplyLeading: false, // Hilangkan tombol panah kembali
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Username: ${userModel.username}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  'Password: ',
                  style: TextStyle(fontSize: 18),
                ),
                if (showPassword)
                  Text(
                    '*' *
                        userModel.password
                            .length, // Tanda bintang sesuai jumlah karakter password
                    style: TextStyle(fontSize: 18),
                  ),
                IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Ganti Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Saat Ini',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Baru',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validasi password saat ini
                if (currentPasswordController.text == userModel.password) {
                  // Ganti password jika valid
                  userModel.changePassword(newPasswordController.text);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Password Berhasil Diubah'),
                        content: Text('Password akun Anda telah diperbarui.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Tampilkan pesan kesalahan jika password saat ini salah
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Password Salah'),
                        content: Text('Password saat ini tidak valid.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Warna latar belakang hijau
                minimumSize: Size(double.infinity, 48), // Lebar penuh
                alignment: Alignment.center, // Teks berada di tengah
              ),
              child: Text('Simpan Perubahan'),
            ),
            SizedBox(height: 16), // Jarak tambahan
            ElevatedButton(
              onPressed: () {
                // Tambahkan fungsi untuk kembali ke halaman sebelumnya
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Warna latar belakang biru
                minimumSize: Size(double.infinity, 48), // Lebar penuh
                alignment: Alignment.center, // Teks berada di tengah
              ),
              child: Text('Kembali'),
            ),
            SizedBox(height: 16), // Jarak tambahan
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey, // Warna latar belakang abu-abu
                  child: Image.asset(
                    'images/foto.jpg', // Ganti dengan path gambar Anda
                    fit: BoxFit.cover, // Sesuaikan cara gambar ditampilkan
                  ),
                ),
                SizedBox(width: 16), // Jarak horizontal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About this app..',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Aplikasi ini dibuat oleh:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Nama: Muhammad Zaki',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'NIM: 2141764106',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Tanggal: 26 September 2023',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
