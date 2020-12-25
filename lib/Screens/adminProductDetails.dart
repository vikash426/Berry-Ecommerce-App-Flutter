import 'package:berry/Services/Database.dart';
import 'package:flutter/material.dart';
import 'package:berry/Classes/product.dart';
import 'package:berry/constants.dart';

class AdminProductDetails extends StatefulWidget {
  final Product product;
  AdminProductDetails(this.product);
  @override
  _AdminProductDetailsState createState() => _AdminProductDetailsState();
}

class _AdminProductDetailsState extends State<AdminProductDetails> {
  String priceUpdated, qtyUpdated;
  int pr,qty;

  @override
  void initState() {
    pr=widget.product.price;
    qty=widget.product.qtyInStock;
        super.initState();
  }
  void showD(Function change, Function press) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Update"),
              content: TextField(
                onChanged: change,
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      press();
                      Navigator.pop(context);
                      setState(() {
                        widget.product.price=pr;
                        widget.product.qtyInStock=qty;
                      });
                    },
                    child: Text("Update")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          
          children: [
            Row(children: [
              Image.network(widget.product.imgLink, height: 150, width: 150),
              Flexible(child: Text(widget.product.name, style: kTextStyle1))
            ]),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Unit Price - ${widget.product.price}",
                    style: productPriceTextStyle),
                IconButton(
                  icon: Icon(Icons.mode_edit),
                  onPressed: () {
                    showD(
                      (value) {
                        priceUpdated = value;
                      },
                      () async{
                        pr=int.parse(priceUpdated);
                        String a=await Database().updatePrice(pr, widget.product.id);
                        print(a);
                      },
                    );
                  },
                )
              ],
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quantity In Stock - ${widget.product.qtyInStock}",
                    style: productPriceTextStyle),
                IconButton(
                  icon: Icon(Icons.mode_edit),
                  onPressed: () {
                    showD(
                      (value) {
                        qtyUpdated = value;},
                      () async {
                        qty=int.parse(qtyUpdated);
                        String a=await Database().updateQty(qty, widget.product.id);
                        print(a);
                      },
                    );
                  },
                )
              ],
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Company", style: productPriceTextStyle),
                Text("${widget.product.company}", style: productPriceTextStyle)
              ],
            )
          ],
        ),
      ),
    );
  }
}
