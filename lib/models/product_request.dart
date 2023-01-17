class ProductRequest {
  DataRequest? data;

  ProductRequest({this.data});

  ProductRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataRequest.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataRequest {
  String? title;
  String? rating;
  String? description;
  String? quantity;
  String? category;
  String? thumbnail;
  String? price;

  DataRequest(
      {this.title,
        this.rating,
        this.description,
        this.quantity,
        this.category,
        this.thumbnail,
        this.price});

  DataRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    rating = json['rating'];
    description = json['description'];
    quantity = json['quantity'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    return data;
  }
}