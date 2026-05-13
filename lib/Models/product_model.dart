class productModel{

  final int id;
  final String name;
  final int price;
  final String description;

  productModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory productModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return productModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString(),).toInt(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "description": description,
    };
  }
}