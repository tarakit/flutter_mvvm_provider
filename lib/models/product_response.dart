class ProductResponse {
  Data? data;

  ProductResponse({this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? title;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? price;
  String? rating;
  String? description;
  String? quantity;

  Attributes(
      {this.title,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
        this.price,
        this.rating,
        this.description,
        this.quantity});

  Attributes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    price = json['price'];
    rating = json['rating'];
    description = json['description'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    return data;
  }
}
