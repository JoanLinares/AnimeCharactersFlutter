class Crew {
  final int id;
  final String name;

  Crew({required this.id, required this.name});

  factory Crew.fromJson(Map<String, dynamic> j) => Crew(
    id:   j['id'],
    name: j['name'],
  );
}
