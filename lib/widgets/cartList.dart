import 'package:berry/Classes/cartProduct.dart';
import 'package:berry/constants.dart';
import 'package:flutter/material.dart';
import 'package:berry/Services/Database.dart';
import 'package:berry/Screens/checkoutPage.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartProduct> cartProducts = [];
  int total = 0;

  int calculateTotal() {
    total=0;
    for (var i in cartProducts) {
      total += i.product.price*i.qty;
    }
    return total;
  }

  @override
  void initState() {
    
    getCart();
    super.initState();
  }
  void getCart(){
    cartProducts = Database().getCart();
    calculateTotal();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (ctxt, index) {
              return ListTile(
                leading: Container(
                  child: Image.network(tempI),
                  height: 150,
                ),
                title: Text(
                    "${cartProducts[index].product.name} x ${cartProducts[index].qty}",
                    style: priceTextStyle),
                subtitle: Text("Rs. ${cartProducts[index].product.price}",
                    style: priceTextStyle),
                trailing: GestureDetector(
                  onTap: (){
                    Database().removeFromCart(index);
                    setState(() {
                      getCart();
                    });
                  },
                  child: Icon(Icons.clear),
                ),
              );
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Total", style: kTextStyle1),
                  Text(
                    "Rs. $total",
                    style: kTextStyle1,
                  )
                ],
              ),
            ),
            Builder(
              builder: (context) => kButton(
                onPress: () async{
                  if (cartProducts.length == 0)
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Your cart is empty")));
                  else {
                    
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CheckoutPage(cartProducts, total)));

                      setState(() {
                        getCart();
                      });
           
                  }
                },
                txt: "Checkout",
              ),
            ),
          ],
        )
      ],
    );
  }
}
