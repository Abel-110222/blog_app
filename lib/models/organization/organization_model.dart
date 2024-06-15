
class OrganizationModel {
  String? id;
  String? name;
  String? imageUrl;
  String? description;
  bool deliveryAllowed;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  OrganizationModel({
    this.id,
    this.name,
    this.imageUrl,
    this.description = '',
    this.deliveryAllowed = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.deletedAt = '',
  });
  factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        description: json["description"] ?? '',
        deliveryAllowed: json["deliveryAllowed"] ?? false,
        createdAt: json["createdAt"] ?? DateTime.now().toString(),
        updatedAt: json["updatedAt"] ?? DateTime.now().toString(),
        deletedAt: json["deletedAt"] ?? DateTime.now().toString(),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "deliveryAllowed": deliveryAllowed,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
      };
}
