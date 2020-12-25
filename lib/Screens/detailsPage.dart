import 'package:berry/Classes/product.dart';
import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'package:berry/Services/Database.dart';
import 'package:berry/Classes/cartProduct.dart';

class DetailsPage extends StatelessWidget {
  final Product product;
  DetailsPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details'), elevation: 0.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
                      child: ListView(
             // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Image.network(product.imgLink),
            Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("${product.name}", style: kTextStyle1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Icon(Icons.star, color: Colors.blue[800]),
                          Text(" 4.5", style: productPriceTextStyle)
                        ]),
                    SizedBox(height: 8.0),
                    Text("Product ID. ${product.id}"),

                    //    SizedBox(height: 8.0),

                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Rs. ${product.price}", style: priceTextStyle),
                    ),
                    SizedBox(height: 8.0),
                    Divider(color: Colors.black45),
                    Text("About Product", style: productTitleTextStyle),
                    Text(product.description),
                    SizedBox(height: 8.0),
                    
                  ],
                )),
                
              ],
            ),
          ),
          kButton(
            onPress:(){
              Database().addToCart(CartProduct(product: product,qty: 1));
            },
            txt:"Add to Cart",
          )
        ],
      ),
    );
  }
}
