import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key, required this.title});
  final String title;

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late String _email;
  late bool _login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInfo();
  }

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email') ?? "");
    _login = (prefs.getBool('login') ?? false);
  }

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Informasi Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text('Email: $_email'),
                const SizedBox(
                  height: 20,
                ),
                Text('Login: $_login'),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () => _handleLogout(),
                    child: const Text('Logout'))
              ],
            ),
          ),
        ));
  }
}
