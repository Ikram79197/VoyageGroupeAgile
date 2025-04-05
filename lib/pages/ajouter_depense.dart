import 'package:flutter/material.dart';
import '../services/memory_storage.dart';
import 'consulter_voyage.dart';

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
  String _categorie = 'Hôtel';

  // Catégories avec leurs icônes correspondantes
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Hôtel', 'icon': Icons.hotel},
    {'name': 'Vol', 'icon': Icons.flight},
    {'name': 'Restaurant', 'icon': Icons.restaurant},
    {'name': 'Transport', 'icon': Icons.directions_car},
    {'name': 'Activités', 'icon': Icons.attractions},
    {'name': 'Autres', 'icon': Icons.more_horiz},
  ];

  void _enregistrerDepense() {
    if (_formKey.currentState!.validate()) {
      final nouvelleDepense = {
        'nom': _nomController.text,
        'montant': double.parse(_montantController.text),
        'categorie': _categorie,
        'date': DateTime.now().toString(),
        'icon': _categories
            .firstWhere((cat) => cat['name'] == _categorie)['icon']
            .codePoint,
      };

      MemoryStorage().addDepense(widget.voyageId, nouvelleDepense);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ConsulterVoyage()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _montantController.dispose();
    super.dispose();
  }

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
              // Section Nom de la dépense
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Nom de la dépense',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  hintText: 'Ex: Dîner au restaurant',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.edit, color: Colors.blue),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 20),

              // Section Montant
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Montant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _montantController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: '0.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefix: const Text('\$ ', style: TextStyle(fontSize: 16)),
                  prefixIcon:
                      const Icon(Icons.attach_money, color: Colors.blue),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Montant requis';
                  if (double.tryParse(value) == null) return 'Montant invalide';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Section Catégorie
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Catégorie',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _categories.map((categorie) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _categorie = categorie['name'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _categorie == categorie['name']
                            ? Colors.blue[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _categorie == categorie['name']
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(categorie['icon'],
                              color: _categorie == categorie['name']
                                  ? Colors.blue
                                  : Colors.grey[700]),
                          const SizedBox(height: 5),
                          Text(
                            categorie['name'],
                            style: TextStyle(
                              color: _categorie == categorie['name']
                                  ? Colors.blue
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Ajouter la dépense',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
