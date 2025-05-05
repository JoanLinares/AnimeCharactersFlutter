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

  factory DevilFruit.fromJson(Map<String, dynamic>? j) {
    if (j == null) {
      return DevilFruit(
        id: 0,
        name: 'None',
        type: '',
        description: '',
        filename: 'https://via.placeholder.com/150',
      );
    }
    return DevilFruit(
      id:          j['id']          as int?    ?? 0,
      name:        j['name']        as String? ?? 'Unknown',
      type:        j['type']        as String? ?? '',
      description: j['description'] as String? ?? '',
      filename:    j['filename']    as String? ?? '',
    );
  }
}
