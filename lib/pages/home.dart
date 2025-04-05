import 'package:flutter/material.dart';
import 'ajouter_voyage.dart';
// Tu peux aussi importer consulter_voyages.dart si tu la crées

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelTogether'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AjouterVoyage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.travel_explore, size: 40),
                    SizedBox(width: 10),
                    Text(
                      "Créer un voyage",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // À remplacer par : Navigator.push vers consulter_voyages
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 40),
                    SizedBox(width: 10),
                    Text(
                      "Consulter les voyages",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
