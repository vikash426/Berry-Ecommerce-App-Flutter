
import 'package:berry/Classes/product.dart';
class CartProduct{
  Product product;
  int qty;

  CartProduct({this.product,this.qty});
  factory CartProduct.fromJson(Map<String, dynamic> json)
  {
    return CartProduct(
    product: Product.fromJson(json),  
    qty:json['qty'] as int,
    );
  } 

  Map toJson()=>{
    'product_id':product.id,
    'qty':qty,
  };



}