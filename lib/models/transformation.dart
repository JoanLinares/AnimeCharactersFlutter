class Transformation {
  final int    id;
  final String name;
  final String image;
  final String ki;

  Transformation({
    required this.id,
    required this.name,
    required this.image,
    required this.ki,
  });

  factory Transformation.fromJson(Map<String, dynamic> j) {
    return Transformation(
      id:   j['id']   as int?    ?? 0,
      name: j['name'] as String? ?? 'Unknown',
      image:j['image']as String? ?? '',
      ki:   j['ki']   as String? ?? '0',
    );
  }
}
