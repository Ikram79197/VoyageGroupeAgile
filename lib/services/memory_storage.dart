class MemoryStorage {
  // Singleton pattern
  static final MemoryStorage _instance = MemoryStorage._internal();
  factory MemoryStorage() => _instance;
  MemoryStorage._internal();

  // Liste pour stocker les voyages
  final List<Map<String, dynamic>> _voyages = [];

  // Dictionnaire pour stocker les dépenses par voyage (clé = voyageId)
  final Map<String, List<Map<String, dynamic>>> _depenses = {};

  // Méthodes pour les voyages

  /// Ajoute un nouveau voyage
  void addVoyage(Map<String, dynamic> voyage) {
    _voyages.add(voyage);
  }

  /// Récupère tous les voyages
  List<Map<String, dynamic>> getVoyages() => List.from(_voyages);

  /// Récupère un voyage spécifique par son ID
  Map<String, dynamic>? getVoyageById(String voyageId) {
    try {
      return _voyages.firstWhere((voyage) => voyage['id'] == voyageId);
    } catch (e) {
      return null;
    }
  }

  // Méthodes pour les dépenses

  /// Ajoute une dépense à un voyage
  void addDepense(String voyageId, Map<String, dynamic> depense) {
    // Initialise la liste si elle n'existe pas
    _depenses[voyageId] ??= [];
    _depenses[voyageId]!.add(depense);
  }

  /// Récupère toutes les dépenses d'un voyage
  List<Map<String, dynamic>> getDepenses(String voyageId) =>
      List.from(_depenses[voyageId] ?? []);

  /// Récupère le total des dépenses pour un voyage
  double getTotalDepenses(String voyageId) {
    if (_depenses[voyageId] == null) return 0.0;
    return _depenses[voyageId]!
        .map((d) => d['montant'] as double)
        .fold(0.0, (a, b) => a + b);
  }

  // Méthode utilitaire

  /// Récupère un voyage avec ses dépenses
  Map<String, dynamic> getVoyageWithDepenses(String voyageId) {
    return {
      'voyage': getVoyageById(voyageId),
      'depenses': getDepenses(voyageId),
      'total': getTotalDepenses(voyageId),
    };
  }

  // Méthodes de debug (optionnel)

  /// Affiche le contenu du stockage (pour debug)
  void debugPrintStorage() {
    print('==== VOYAGES ====');
    _voyages.forEach(print);
    print('==== DEPENSES ====');
    _depenses.forEach((key, value) {
      print('Voyage $key:');
      value.forEach(print);
    });
  }
}
