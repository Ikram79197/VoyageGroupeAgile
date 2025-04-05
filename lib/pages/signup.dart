import 'package:flutter/material.dart';
import 'home.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                labelText: "Nom Complet",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: "Numéro du téléphone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirmer le mot de passe",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
