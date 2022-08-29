class VoteCatModel {
  int? id;
  String? imageId;
  String? subId;
  String? createdAt;
  int? value;
  String? countryCode;
  VoteImageModel? image;

  VoteCatModel(
      {this.id,
      this.imageId,
      this.subId,
      this.createdAt,
      this.value,
      this.countryCode,
      this.image});

  VoteCatModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imageId = json["image_id"];
    subId = json["sub_id"];
    createdAt = json["created_at"];
    value = json["value"];
    countryCode = json["country_code"];
    image =
        json["image"] == null ? null : VoteImageModel.fromJson(json["image"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["image_id"] = imageId;
    data["sub_id"] = subId;
    data["created_at"] = createdAt;
    data["value"] = value;
    data["country_code"] = countryCode;
    if (image != null) {
      data["image"] = image?.toJson();
    }
    return data;
  }
}

class VoteImageModel {
  String? id;
  String? url;

  VoteImageModel({this.id, this.url});

  VoteImageModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["url"] = url;
    return data;
  }
}
