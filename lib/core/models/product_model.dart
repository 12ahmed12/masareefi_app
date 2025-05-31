class ProductModel {
  int productId = 0;
  int? productOrder;
  int availableQty = 0;
  int? productMinOrder;
  int? productMaxOrder;
  double? price;
  double? oldPrice;
  double? discountPrice;
  double? weight;
  double? discountPercentage;
  bool? isNew;
  String productName = '';
  String? productDescription;
  List<ProductGallery>? productGallery;
  ProductModel(
      {required this.productId,
      required this.productName,
      this.price,
      this.productGallery,
      required this.availableQty});

  @override
  String toString() {
    return 'ProductDetails{productId=$productId,weight=$weight,productName=$productName,'
        'availableQty=$availableQty,price=$price,productGallery=$productGallery}';
  }

  static List<ProductModel> listFromJson(List<dynamic> json) {
    return json.isEmpty
        ? []
        : json.map((value) => ProductModel.fromJson(value)).toList();
  }

  static Map<String, ProductModel> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ProductModel>();
    if (json.isNotEmpty && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = ProductModel.fromJson(value));
    }
    return map;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productOrder = json['productOrder'];
    weight = json['weight'];
    availableQty = json['availableQty'];
    productMinOrder = json['productMinOrder'];
    productMaxOrder = json['productMaxOrder'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discountPrice = json['discountPrice'];
    discountPercentage = json['discountPercentage'];
    isNew = json['isNew'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productGallery = ProductGallery.listFromJson(json['productGallery']);
  }
}

class ProductGallery {
  String? urlPath;

  ProductGallery({this.urlPath});

  @override
  String toString() {
    return 'urlPath=$urlPath';
  }

  ProductGallery.fromJson(Map<String, dynamic> json) {
    urlPath = json['urlPath'];
  }

  static List<ProductGallery> listFromJson(List<dynamic> json) {
    return json.isEmpty
        ? []
        : json.map((value) => ProductGallery.fromJson(value)).toList();
  }
}
