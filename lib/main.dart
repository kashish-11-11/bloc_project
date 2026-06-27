import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_given_by_sayyam/features/cart/bloc/cart_bloc.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_bloc.dart';
import 'package:project_given_by_sayyam/features/router.dart';
import 'package:project_given_by_sayyam/features/splash/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => product_bloc()),
     
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // routeInformationParser: approuter().router.routeInformationParser,
        // routerDelegate: approuter().router.routerDelegate,
        routerConfig: approuter.router,

        // added 2 more properties
      ),
    );
  }
}
