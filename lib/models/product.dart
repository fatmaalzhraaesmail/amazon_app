class products {
  int id;
  String title;
  num price;
  String description;
  String category;
  String image;
  Map<dynamic,dynamic>? rating;
  products({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
     this.rating,
  });
  // List<products> myproduct = [];
  
  // factory products.fromJson(Map<String, dynamic> json) {
  //   return products(
  //       id: json['id'],
  //       title: json['title'],
  //       category: json['category'],
  //       description: json['description'],
  //       price: json['price'],
  //       image: json['description'],
  //       rating: json['rating'],
        
  //       );

  // }
}
