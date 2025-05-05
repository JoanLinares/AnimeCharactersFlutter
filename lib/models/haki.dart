class Haki {
  final int    id;
  final String name;
  final String type;

  Haki({required this.id, required this.name, required this.type});

  factory Haki.fromJson(Map<String, dynamic> j) => Haki(
    id:   j['id'],
    name: j['name'],
    type: j['type'],
  );
}
