import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'package:berry/Classes/product.dart';
import 'package:berry/Services/Database.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  Product pr=Product();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
               Text("Add Product",style: titleTextStyle,),
               SizedBox(height:8.0),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: "Product_ID"),
              onChanged: (value) {
                pr.id = int.parse(value);
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Product Name"),
              onChanged: (value) {
                pr.name = value;
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              maxLines: 2,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: "Product Description"),
              onChanged: (value) {
                pr.description = value;
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: "Price"),
              onChanged: (value) {
                pr.price = int.parse(value);
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: "Company"),
              onChanged: (value) {
                pr.company = value;
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Quantity In Stock"),
              onChanged: (value) {
                pr.qtyInStock = int.parse(value);
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Product ImageLink"),
              onChanged: (value) {
                pr.imgLink = value;
              },
            ),
            SizedBox(height: 12.0),
            Builder(
              builder: (context)=> kButton(
                txt: "Add Product",
                onPress:  () async{
                          String a= await Database().addProduct(pr);

                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(a),));
                        }
              ),
            ),
            
          ]),
        ),
      ),
    );
  }
}
