import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_given_by_sayyam/features/cart/view/my_bag.dart';
import 'package:project_given_by_sayyam/features/home/view/home_screen.dart';
import 'package:project_given_by_sayyam/features/login/view/login_screen.dart';
import 'package:project_given_by_sayyam/features/register/view/register_screen.dart';
import 'package:project_given_by_sayyam/features/splash/view/splash_screen.dart';

class routesname {
  static String home = 'home';
  static String login = 'login';
  static String register = 'register';
  static String splash = 'splash';
  static String add_to_cart = 'add_to_cart';
}

class approuter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: routesname.login,
        path: '/login',
        //after navigating what we need to do is pagebuilder property
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: routesname.splash,
        path: '/',
        //after navigating what we need to do is pagebuilder property
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: routesname.register,
        path: '/register',
        //after navigating what we need to do is pagebuilder property
        pageBuilder: (context, state) {
          return const MaterialPage(child: RegisterScreen());
        },
      ),

      GoRoute(
        name: routesname.home,
        path: '/home',
        //after navigating what we need to do is pagebuilder property
        pageBuilder: (context, state) {
          return const MaterialPage(child: Homescreen());
        },
      ),
      GoRoute(
        name: routesname.add_to_cart,
        path: '/add_to_cart',
        //after navigating what we need to do is pagebuilder property
        pageBuilder: (context, state) {
          return const MaterialPage(child: my_bag());
        },
      ),
    ],
    // In the go router class there is a property, of redirect, in which condns can be applied of login or register or home
    // redirect: (context, state) async {
    //   bool isAuthenticated = false;
    //   if (isAuthenticated == false) {
    //     return state.namedLocation(routesname.login);
    //   }
    //   return null;
    // },
  );
  // it needs argument, a list of routebases
}
