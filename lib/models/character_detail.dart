class CharacterDetail {
  final int    id;
  final String name;
  final String nameKanji;
  final String imageUrl;
  final int    favorites;
  final String about;

  CharacterDetail({
    required this.id,
    required this.name,
    required this.nameKanji,
    required this.imageUrl,
    required this.favorites,
    required this.about,
  });

  factory CharacterDetail.fromJson(Map<String, dynamic> json) {
    final d    = json['data'] as Map<String, dynamic>;
    final jpg  = d['images']['jpg']  as Map<String, dynamic>;
    final webp = d['images']['webp'] as Map<String, dynamic>;

    final url = (webp['image_url'] as String?) ?? (jpg['image_url'] as String);

    return CharacterDetail(
      id:        d['mal_id']               as int,
      name:      d['name']                 as String,
      nameKanji: d['name_kanji'] as String? ?? '',
      imageUrl:  url,
      favorites: d['favorites']    as int?   ?? 0,
      about:     d['about']         as String? ?? 'No description.',
    );
  }
}
