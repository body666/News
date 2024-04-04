class SourcesResponse {
  SourcesResponse({
      this.status, 
      this.sources,
      this.code,
      this.message,
  });

  SourcesResponse.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(Sources.fromJson(v));
      });
    }
  }
  String? code;
  String? message;
  String? status;
  List<Sources>? sources;


}

class Sources {
  Sources({
      this.code,
      this.message,
      this.id, 
      this.name, 
      this.description, 
      this.url, 
      this.category, 
      this.language, 
      this.country,});

  Sources.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }
  String? code;
  String? message;
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;



}