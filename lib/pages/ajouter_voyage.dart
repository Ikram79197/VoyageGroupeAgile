import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../services/memory_storage.dart';
import 'ajouter_depense.dart';

class AjouterVoyage extends StatefulWidget {
  const AjouterVoyage({super.key});

  @override
  State<AjouterVoyage> createState() => _AjouterVoyageState();
}

class _AjouterVoyageState extends State<AjouterVoyage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _lieuController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final uuid = Uuid(); // Générateur UUID

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Génère un ID unique
      String voyageId = uuid.v4();

      // Crée l'objet voyage
      final voyage = {
        'id': voyageId,
        'nom': _nomController.text,
        'lieu': _lieuController.text,
        'date': _dateController.text,
      };

      // Enregistre dans le stockage
      MemoryStorage().addVoyage(voyage);

      // Navigue vers AjouterDepense
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AjouterDepense(voyageId: voyageId),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _lieuController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un voyage'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom du voyage',
                  border: OutlineInputBorder(),
                  hintText: 'Ex: Vacances à Paris',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lieuController,
                decoration: const InputDecoration(
                  labelText: 'Lieu/Adresse',
                  border: OutlineInputBorder(),
                  hintText: 'Ex: Tour Eiffel, Paris',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: const OutlineInputBorder(),
                  hintText: 'jj/mm/aaaa',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 50),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Suivant'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
