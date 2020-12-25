import 'package:berry/Classes/cartProduct.dart';
import 'package:berry/Services/Database.dart';
import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'package:berry/Classes/order.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartProduct> cartProducts;
  final int total;
  CheckoutPage(this.cartProducts, this.total);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String address;
  var formatter = new DateFormat('yyy-MM-dd');
  int dFee = 124;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(Icons.location_on, color: Colors.red[400]),
              Text("Delivery Address", style: titleTextStyle)
            ]),
            SizedBox(height: 8.0),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText:""),
              maxLines: 2,
              onChanged: (value) {
                address = value;
              },
            ),
            SizedBox(height: 15.0),
            Row(children: [
              Icon(Icons.account_balance_wallet, color: Colors.red[400]),
              Text("Payment Method", style: titleTextStyle)
            ]),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: productPriceTextStyle),
                Text(
                  "Rs. ${widget.total}",
                  style: productPriceTextStyle,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Fee", style: productPriceTextStyle),
                Text(
                  "Rs. --",
                  style: productPriceTextStyle,
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text(""),
              ),
            ),
            Builder(
              builder: (context) => kButton(
                txt: "Confirm Order",
                onPress: () async {
                  if (address == null) {
                    // var snackbar=SnackBar(content: Text("Fill Adress Field"));
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Fill Address Field")));
                  } else {
                    String a = await Database().createOrder(Order(
                        custId: currentCustomer.id,
                        orderDate: formatter.format(DateTime.now()),
                        amount: widget.total,
                        status: "Pending",
                        deliveryAdress: address));

                    if (a == "Error Placing Order") {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Error placing Order")));
                    } else {
                      Database().clearCart();
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("ORDER# $a"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Placed Succesfully"),
                                  Text('Total : ${widget.total}'),
                                  Text("Adress - $address")
                                ],
                              ),
                            );
                          });
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
