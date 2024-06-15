// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/providers/organizations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/Pages/home.dart';
import 'package:blog_app/Pages/splash_page.dart';
import 'package:blog_app/bloc/theme.dart';
import 'package:blog_app/providers/categories_provider.dart';
import 'package:blog_app/providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrganizationsProvider>(create: (_) => OrganizationsProvider()),
        ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
        ChangeNotifierProvider<CategoriesProvider>(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
      ],
      child: Builder(
        builder: (context) {
          final themeChanger = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blogs App',
            theme: themeChanger.isDarkMode
                ? ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark().copyWith(
                      primary: Colors.teal,
                      secondary: Colors.deepOrange,
                      surface: Colors.grey[900]!,
                      background: Colors.black,
                      error: Colors.red,
                      onPrimary: Colors.white,
                      onSecondary: Colors.white,
                      onSurface: Colors.white,
                      onBackground: Colors.white,
                      onError: Colors.white,
                    ),
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    colorScheme: const ColorScheme.light().copyWith(
                      background: Colors.white,
                      primary: Colors.blue,
                      secondary: Colors.red,
                    ),
                  ),
            initialRoute: '/SplashPageRoute',
            routes: {
              'view_Home': (context) => const Home(),
              '/SplashPageRoute': (context) => const LoginPage(),
              // 'View_Home_web': (context) => const HomeWeb(),
            },
          );
        },
      ),
    );
  }
}
