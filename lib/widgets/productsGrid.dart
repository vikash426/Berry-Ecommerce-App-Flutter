import 'package:berry/Classes/product.dart';
import 'package:flutter/material.dart';
import 'package:berry/widgets/productCard.dart';
//import 'package:berry/Screens/detailsPage.dart';


class ProductGrid extends StatelessWidget {
  final Function onClick;
  final List<Product> products;
  final Function w;
  final Widget topWidget;
  ProductGrid({this.products,this.onClick,this.w,this.topWidget});
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            topWidget,
            Expanded(
                          child: Container(
        padding: EdgeInsets.all(8.0),
        child: GridView.count(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          children: List.generate(
                products.length,
                (index) => GestureDetector(
                      onTap: (){
                        onClick(products[index]);
                      },
                      child: ProductCard(
                        product:products[index],
                        w:w,
                      ),
                    )),
        ),
      ),
            ),
          ]);
  }
}
