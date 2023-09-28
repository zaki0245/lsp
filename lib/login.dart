import 'package:flutter/material.dart';
import 'package:lsp/home.dart';
import 'package:lsp/register.dart';
import 'package:lsp/user_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> _checkLogin(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final database = await openDatabase(
      join(await getDatabasesPath(), 'user_database1.db'),
      version: 1,
    );

    final db = await database;

    final List<Map<String, dynamic>> users = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);

    if (users.isNotEmpty) {
      // Login berhasil
      Provider.of<UserModel>(context, listen: false)
          .setUser(username, password);
      return true;
    } else {
      // Login gagal
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Username atau password salah.'),
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
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/logo.png', // Ganti dengan path gambar Anda
                width: 100, // Sesuaikan lebar gambar sesuai kebutuhan
                height: 100, // Sesuaikan tinggi gambar sesuai kebutuhan
              ),
              SizedBox(height: 8), // Jarak tambahan antara gambar dan teks
              Text(
                'MyCashBook v1.0',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final loginSuccess = await _checkLogin(context);
                  if (loginSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
