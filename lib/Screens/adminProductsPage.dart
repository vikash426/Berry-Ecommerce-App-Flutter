import 'package:berry/Classes/product.dart';
import 'package:berry/widgets/productsGrid.dart';
import 'package:flutter/material.dart';
import 'package:berry/Services/Database.dart';
//import 'package:berry/constants.dart';
import 'package:berry/Screens/addProduct.dart';
import 'package:berry/Screens/adminProductDetails.dart';

class AdminProductsPage extends StatefulWidget {
  @override
  _AdminProductsPageState createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  List<Product> products;
  Product pr = Product();
  bool got = true;
  void getP() async {
    products = await Database().getProducts();

    setState(() {
      got = false;
    });
  }

  @override
  void initState() {
    getP();

    super.initState();
  }

  BuildContext dialogContext;
  String a;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: got
          ? CircularProgressIndicator()
          : ProductGrid(
            topWidget: SizedBox(height:0.0),
              products: products,
              w: (Product pr) {
                return GestureDetector(
                  child: Icon(Icons.delete_outline),
                  onTap: () async {
                    await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are you Sure"),
                        actions: [
                          FlatButton(
                            onPressed: () async{
                              String a =await Database().deleteProduct(pr.id);
                              print(a);
                              Navigator.pop(context);
                            },
                            child: Text("YES"),
                          ),
                          FlatButton(
                            onPressed: null,
                            child: Text("NO"),
                          )
                        ],
                      );
                    });

                    setState(() {
                      print("getp Called");
                      getP();
                    });
                  },
                );
              },
              onClick: (Product p) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProductDetails(p),));
              },
            ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProductPage()));
            setState(() {
              getP();
            });
          }),
    );
  }
}
