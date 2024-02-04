class CompanyModel {
  String? name;
  String? logoPath;

  CompanyModel({this.logoPath, this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> map) {
    return CompanyModel(
      name: map['name'] ?? "Unknown",
      logoPath: map['logo_path'] ?? "",
    );
  }
}
