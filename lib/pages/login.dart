import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight, size: 80, color: Colors.blue),
            const SizedBox(height: 10),
            const Text(
              "TravelTogether",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text("Mot de passe oublié ?",
                  style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text("Log In"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text("Sign In", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
