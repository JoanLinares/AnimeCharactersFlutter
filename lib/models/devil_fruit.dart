class DevilFruit {
  final int    id;
  final String name;
  final String type;
  final String description;
  final String filename;

  DevilFruit({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.filename,
  });

  factory DevilFruit.fromJson(Map<String, dynamic> j) => DevilFruit(
    id:          j['id'],
    name:        j['name'],
    type:        j['type'],
    description: j['description'],
    filename:    j['filename'],
  );
}
