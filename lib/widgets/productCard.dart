import 'package:berry/constants.dart';
import 'package:flutter/material.dart';
import 'package:berry/Classes/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {

 
  final Function w;
  final Product product;
  ProductCard({this.product,this.w});

  Widget getW(){
    return w(product);
  }
  Widget returnImage(){
    try {
    return CachedNetworkImage(
        useOldImageOnUrlChange: true,
        imageUrl: product.imgLink,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) {
            return Image(
                image: AssetImage('images/berryLogo.jpg'),
            );
        },
    );
} catch (e) {
    return Image(
        image: AssetImage('images/berryLogo.jpg'),
    );
}

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
                child: Container(
                height: 180,             
                 child: Image.network(product.imgLink),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(4.0),
              child: Text("${product.name}", style: productTitleTextStyle,overflow: TextOverflow.ellipsis,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:4.0),
              child: Row(
                children: [
                  Text('Rs. ${product.price}', style: productPriceTextStyle),
                  getW()
                ],
              ),
            ),
          ]),
    );
  }
}
