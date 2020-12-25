
class Product
{
  int id;
  String name;
  int price;
  int categoryID;
  String description;
  String company;
  int qtyInStock;
  String imgLink;
  

  Product({this.id,this.name,this.price,this.description,this.company,this.qtyInStock,this.imgLink,this.categoryID});
  factory Product.fromJson(Map<String, dynamic> json)
  {
    return Product(
    id:json['product_id'] as int,
    name:json['product_name'] as String,
    price:json['unit_price'] as int,
    description:json['product_description'] as String,
    company:json['company_name'] as String,
    qtyInStock:json['qty_in_stock'] as int,
    imgLink:json['imglink'] as String,
    categoryID: json['category']
    );
  } 

  
}