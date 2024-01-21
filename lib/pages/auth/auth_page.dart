import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundbox/core/models/user_model.dart';
import 'package:soundbox/providers/user_provider.dart';
import 'package:soundbox/pages/home/home_page.dart';
import 'package:soundbox/services/pocketbase_service.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleLogin(context) async {
    if (!formKey.currentState!.validate()) return;
    PocketBaseService pb = PocketBaseService.instance;
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    User user = await pb.login(
        _usernameController.value.text, _passwordController.value.text);
    userProvider.setUser(user);
    if (pb.hasValidToken && context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');
                          if (value == null || value.isEmpty) {
                            return "Username is required";
                          } else if (!regex.hasMatch(value)) {
                            return "Invalid username";
                          }
                          return null;
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                            label: const Text("Username"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            label: const Text("Password"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          onPressed: () => handleLogin(context),
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              child: const Text("Login",
                                  textAlign: TextAlign.center)))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
