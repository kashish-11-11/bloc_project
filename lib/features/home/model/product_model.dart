class product_model {
  final int id;
  final String name;
  final String description;
  final int price;
  final bool availability;
  final String image;
  final bool addedToCart;
  final int quantity;
  final bool isSold;
  int? items_sold;
  int? quantity_added_for_cart;
  product_model({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.availability,
    required this.image,
    required this.addedToCart,
    required this.quantity,
    required this.isSold,
    this.quantity_added_for_cart,
    this.items_sold
  });
  factory product_model.fromJson(Map<String, dynamic> json) {
    return product_model(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      availability: json["availability"],
      image: json["image"],
      addedToCart: json["added_to_cart"],
      quantity: int.parse(json["quantity"]),
      isSold: json["issold"],
      quantity_added_for_cart: json["quantity_added_for_cart"] != null
          ? int.parse(json["quantity_added_for_cart"].toString())
          : 0,
          items_sold: json["items_sold"] != null ?json["items_sold"] : 0
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'availability': availability,
      'image': image,
      'added_to_cart': addedToCart,
      'quantity': quantity,
      'issold': isSold,
      'quantity_added_for_cart': quantity_added_for_cart,
      'items_sold' : items_sold
    };
  }

  product_model copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    bool? availability,
    String? image,
    bool? addedToCart,
    int? quantity,
    bool? isSold,
    int? quantity_added_for_cart,
    int? items_sold,
  }) {
    return product_model(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      availability: availability ?? this.availability,
      image: image ?? this.image,
      addedToCart: addedToCart ?? this.addedToCart,
      quantity: quantity ?? this.quantity,
      isSold: isSold ?? this.isSold,
      quantity_added_for_cart:
          quantity_added_for_cart ?? this.quantity_added_for_cart,
       items_sold:    items_sold ?? this.items_sold ,
    );
  }

  @override
  String toString() {
    return 'product_model(id: $id, name: $name, price: $price, addedToCart: $addedToCart, isSold: $isSold)';
  }
}
