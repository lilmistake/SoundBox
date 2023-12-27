import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/pages/home/home_page.dart';
import 'package:soundbox/core/providers/song_provider.dart';
import 'package:soundbox/core/providers/theme_provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => SongProvider()),
    ], child: const Root());
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData(themeProvider.brightness),
        home: const HomePage());
  }
}