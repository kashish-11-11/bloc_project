import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_given_by_sayyam/features/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadsession();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF0A73B7),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.book, color: Colors.white, size: 40),
              SizedBox(width: 10),
              Text(
                'BOOK HEAVEN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadsession() async {
     await Future.delayed(const Duration(seconds: 2));
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? status = await sp.getString("isLogin");
    if (status == "true") {
      context.goNamed(routesname.home);
      return;
    }
    context.goNamed(routesname.register);
    return;
  }
}
