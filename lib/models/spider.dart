class Spider {
  final int id;
  final String name;
  final String description;
  final String toxicity;

  Spider({this.id, this.description, this.toxicity, this.name});

  factory Spider.fromJson(Map<String, dynamic> json) {
    return new Spider(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      toxicity: json['toxicity'] as String,
    );
  }
}
