class ProductModel {
  int? status;
  String? message;
  List<Data>? data;

  ProductModel({this.status, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? intGlcode;
  String? fkCategory;
  String? varTitle;
  String? oldPrice;
  String? newPrice;
  String? varOffer;
  List<ProductVariations>? productVariations;
  List<Images>? images;

  Data(
      {this.intGlcode,
      this.fkCategory,
      this.varTitle,
      this.oldPrice,
      this.newPrice,
      this.varOffer,
      this.productVariations,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    intGlcode = json['int_glcode'];
    fkCategory = json['fk_category'];
    varTitle = json['var_title'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    varOffer = json['var_offer'];
    if (json['product_variations'] != null) {
      productVariations = <ProductVariations>[];
      json['product_variations'].forEach((v) {
        productVariations!.add(new ProductVariations.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['int_glcode'] = this.intGlcode;
    data['fk_category'] = this.fkCategory;
    data['var_title'] = this.varTitle;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['var_offer'] = this.varOffer;
    if (this.productVariations != null) {
      data['product_variations'] =
          this.productVariations!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariations {
  String? varSize;
  String? fkUnit;
  String? fkColor;
  String? varPrice;

  ProductVariations({this.varSize, this.fkUnit, this.fkColor, this.varPrice});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    varSize = json['var_size'];
    fkUnit = json['fk_unit'];
    fkColor = json['fk_color'];
    varPrice = json['var_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['var_size'] = this.varSize;
    data['fk_unit'] = this.fkUnit;
    data['fk_color'] = this.fkColor;
    data['var_price'] = this.varPrice;
    return data;
  }
}

class Images {
  String? varImageUrl;

  Images({this.varImageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    varImageUrl = json['var_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['var_image_url'] = this.varImageUrl;
    return data;
  }
}
