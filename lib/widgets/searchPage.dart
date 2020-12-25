import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'package:berry/Classes/product.dart';

class SearchPage extends StatefulWidget {
  final List<Product> products;
  SearchPage(this.products);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller;
  List<Product> searchedProducts = [];

  @override
  void initState() {
   // searchedProducts.add(widget.products[0]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            
            // keyboardType: TextInputTy,
            controller: controller,
            decoration: kTextFieldDecoration.copyWith(hintText:"Search Products"),
            onSubmitted: (value) {
              print(value);
              setState(() {
                searchedProducts.clear();
              for (var pr in widget.products){
                String hj=pr.name.toLowerCase();
                if(hj.contains(value))
                searchedProducts.add(pr);
              }
              });             

            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedProducts.length,
              itemBuilder: (context,index){
              return ProductTile(searchedProducts[index]);
            }),
          ),
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile(this.product);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Row(
        children: [
          Image.network(product.imgLink,height: 100,width:100),
          Expanded(
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,style: productPriceTextStyle,overflow: TextOverflow.ellipsis,),
                SizedBox(height:8.0),
                Text("${product.price}",style: productPriceTextStyle)
              ],
            ),
          ),
        ],
      )
    );
  }
}
