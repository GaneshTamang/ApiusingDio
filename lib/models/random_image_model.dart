// ignore_for_file: prefer_collection_literals

class RandomImageModel {
  String? id;
  int? width;
  int? height;
  String? url;

  RandomImageModel({this.id, this.width, this.height, this.url});

  RandomImageModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    width = json["width"];
    height = json["height"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["width"] = width;
    data["height"] = height;
    data["url"] = url;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
