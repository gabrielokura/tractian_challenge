class CompanyApiModel {
  final String id;
  final String name;

  CompanyApiModel({required this.id, required this.name});

  factory CompanyApiModel.fromJson(Map<String, Object?> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;

    return CompanyApiModel(id: id, name: name);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
