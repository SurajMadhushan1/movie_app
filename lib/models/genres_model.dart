class GenresModel {
  String? name;

  GenresModel({this.name});

  factory GenresModel.fromJson(Map<String, dynamic> map) {
    return GenresModel(name: map['name'] ?? "unknown");
  }
}
