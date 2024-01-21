import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/user_model.dart';
import 'package:soundbox/providers/user_provider.dart';
import 'package:soundbox/pages/auth/auth_page.dart';
import 'package:soundbox/pages/home/home_page.dart';
import 'package:soundbox/providers/song_provider.dart';
import 'package:soundbox/providers/theme_provider.dart';
import 'package:soundbox/services/pocketbase_service.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  var pb = await PocketBaseService.init();
  
  await pb.adminLogin();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => SongProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider())
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
        home: const Redirector());
  }
}

class Redirector extends StatelessWidget {
  const Redirector({super.key});

  Future<Widget> verify(context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    PocketBaseService pb = PocketBaseService.instance;
    Widget redirect;

    if (!pb.hasValidToken) {
      redirect = AuthPage();
    } else {
      try {
        User user = await pb.getUser();
        userProvider.setUser(user);
        redirect = const HomePage();
      } catch (e) {
        redirect = AuthPage();
      }
    }
    return redirect;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: () async {
      return await verify(context);
    }(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return snapshot.data!;
    });
  }
}

/* ("testusername", "testpassword");*/