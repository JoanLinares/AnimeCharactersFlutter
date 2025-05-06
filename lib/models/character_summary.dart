class CharacterSummary {
  final int    id;
  final String name;
  final String imageUrl;

  CharacterSummary({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CharacterSummary.fromJson(Map<String, dynamic> j) {
    final c    = j['character'] as Map<String, dynamic>;
    final jpg  = c['images']['jpg']  as Map<String, dynamic>;
    final webp = c['images']['webp'] as Map<String, dynamic>;

    // Usa la URL de webp de alta resolución, no la "small"
    final url = (webp['image_url'] as String?) ?? (jpg['image_url'] as String);

    return CharacterSummary(
      id:       c['mal_id']    as int,
      name:     c['name']      as String,
      imageUrl: url,
    );
  }
}
