class Place {
  final String name;
  final double lat;
  final double long;

  Place({
    required this.name,
    required this.lat,
    required this.long,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name:
          '${json['region'] ?? json['formatted'] ?? 'N/A'}, ${json['state'] ?? 'N/A'}, ${json['country'] ?? 'N/A'}',
      lat: json['lat'] ?? 0.0,
      long: json['long'] ?? 0.0,
    );
  }
}
