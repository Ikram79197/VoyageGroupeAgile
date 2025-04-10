import 'package:flutter/material.dart';
import '../services/memory_storage.dart';
import 'ajouter_voyage.dart';
import 'ajouter_depense.dart';
import 'home.dart'; // Assurez-vous que ce fichier existe et contient HomePage

class ConsulterVoyage extends StatefulWidget {
  const ConsulterVoyage({super.key});

  @override
  State<ConsulterVoyage> createState() => _ConsulterVoyageState();
}

class _ConsulterVoyageState extends State<ConsulterVoyage> {
  @override
  Widget build(BuildContext context) {
    final voyages = MemoryStorage().getVoyages();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Les Voyages disponibles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjouterVoyage()),
              );
              setState(() {}); // Rafraîchir la liste
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: voyages.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flight, size: 50, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Aucun voyage enregistré',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Appuyez sur + pour ajouter un voyage',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                      return;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: voyages.length,
                      itemBuilder: (context, index) {
                        final voyage = voyages[index];
                        return _buildVoyageCard(voyage, context);
                      },
                    ),
                  ),
          ),

          //  Bouton Accueil en bas, centré avec texte sous l'icône
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.home, size: 25), // Icône de la maison

                    Text('Accueil',
                        style: TextStyle(fontSize: 14)), // Texte "Accueil"
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoyageCard(Map<String, dynamic> voyage, BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjouterDepense(voyageId: voyage['id']),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nom + Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    voyage['nom'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    voyage['date'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Lieu
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    voyage['lieu'],
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Lien vers les dépenses
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Ajouter des dépenses',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
