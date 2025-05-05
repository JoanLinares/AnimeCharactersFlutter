class OriginPlanet {
  final int    id;
  final String name;
  final bool   isDestroyed;
  final String description;
  final String image;

  OriginPlanet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
  });

  factory OriginPlanet.fromJson(Map<String, dynamic>? j) {
    if (j == null) {
      return OriginPlanet(
        id: 0,
        name: 'Unknown',
        isDestroyed: false,
        description: '',
        image: '',
      );
    }
    return OriginPlanet(
      id:          j['id']          as int?    ?? 0,
      name:        j['name']        as String? ?? 'Unknown',
      isDestroyed: j['isDestroyed'] as bool?   ?? false,
      description: j['description'] as String? ?? '',
      image:       j['image']       as String? ?? '',
    );
  }
}
