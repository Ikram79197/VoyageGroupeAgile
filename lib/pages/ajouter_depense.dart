import 'package:flutter/material.dart';
import '../services/memory_storage.dart';

class AjouterDepense extends StatefulWidget {
  final String voyageId;
  const AjouterDepense({super.key, required this.voyageId});

  @override
  State<AjouterDepense> createState() => _AjouterDepenseState();
}

class _AjouterDepenseState extends State<AjouterDepense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  String _categorie = 'Hôtel'; // Catégorie par défaut

  // Liste des catégories disponibles
  final List<String> _categories = [
    'Hôtel',
    'Transport',
    'Nourriture',
    'Activités',
    'Autres'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une dépense'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Nom de la dépense
              const Text('Nom de la dépense',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  hintText: 'Ex: Dîner au restaurant',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.edit),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 20),

              // Section: Montant
              const Text('Montant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _montantController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: '0.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefix: const Text('\$ '),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Montant requis';
                  if (double.tryParse(value) == null) return 'Montant invalide';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Section: Catégories
              const Text('Catégorie',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _categories.map((categorie) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _categorie == categorie
                          ? Colors.blue
                          : Colors.grey[200],
                      foregroundColor:
                          _categorie == categorie ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _categorie = categorie;
                      });
                    },
                    child: Text(categorie),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),

              // Bouton Valider
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _enregistrerDepense,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Ajouter la dépense',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enregistrerDepense() {
    if (_formKey.currentState!.validate()) {
      final nouvelleDepense = {
        'nom': _nomController.text,
        'montant': double.parse(_montantController.text),
        'categorie': _categorie,
        'date': DateTime.now().toString(),
      };

      // Enregistrement dans MemoryStorage
      MemoryStorage().addDepense(widget.voyageId, nouvelleDepense);

      // Feedback utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dépense enregistrée avec succès!')),
      );

      // Retour à la page précédente
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _montantController.dispose();
    super.dispose();
  }
}
