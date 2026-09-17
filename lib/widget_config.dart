class ComponentConfig {
  final String id;
  final String type; // Örn: 'search', 'story', 'banner' vb.
  Map<String, dynamic> properties; // Renkler, başlıklar ve diğer ayarlar

  ComponentConfig({
    required this.id,
    required this.type,
    required this.properties,
  });
}
