import 'package:berry/Classes/cartProduct.dart';
import 'package:berry/constants.dart';
import 'package:flutter/material.dart';
import 'package:berry/Classes/order.dart';
import 'package:berry/Services/Database.dart';
import 'package:berry/Classes/product.dart';

class AdminOrderDetails extends StatefulWidget {
  final Order order;
  AdminOrderDetails(this.order);
  @override
  _AdminOrderDetailsState createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  double discreteValue;
  String custName;
  bool got = true;
  List<CartProduct> orderItems = [];
  Product product =
      Product(id: 101, name: "vikash", price: 450, description: "Description");

  void getName() async {
    custName = await Database().getCustName(widget.order.custId);
    orderItems = await Database().getCartProducts(widget.order.orderId);
    setState(() {
      got = false;
    });
  }
  double getIntStatus(){
    if(widget.order.status=="Pending")
     return 0.0;
    else if(widget.order.status=="Shipped")
     return 1.0;
    else 
    return 2.0; 
  }
  @override
  void initState() {
    discreteValue=getIntStatus();
    getName();
    super.initState();
  }
  String getStatus(){
    if(discreteValue==0)
    return "Pending";
    else if(discreteValue==1)
    return "Shipped";
    else
    return "Delivered";
  }
  void changeStatus() async{
    String a=await Database().updateStatus(getStatus(), widget.order.orderId);
    print(a);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 1.0, title: Text("Order# ${widget.order.orderId}")),
        body: got
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: orderItems.length,
                          itemBuilder: (ctxt, index) {
                            return ListTile(
                              leading: Image.network(tempI),
                              title: Text(
                                  "${orderItems[index].product.name} x ${orderItems[index].qty}",
                                  style: priceTextStyle),
                              subtitle: Text(
                                  "Rs. ${orderItems[index].product.price}",
                                  style: priceTextStyle),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text("Customer Name -         $custName",
                          style: productPriceTextStyle),
                      SizedBox(height: 12.0),
                      Text("Order Date -            ${widget.order.orderDate}",
                          style: productPriceTextStyle),
                      SizedBox(height: 12.0),
                      Text(
                          "Delivery Address -      ${widget.order.deliveryAdress}",
                          style: productPriceTextStyle),
                      SizedBox(height: 12.0),
                      Slider(
                        inactiveColor: Colors.white,
                        value: discreteValue,
                        min:0,
                        max:2,
                        divisions: 2,
                        onChanged: (value){
                          setState(() {
                            discreteValue=value;
                            widget.order.status=getStatus();
                            changeStatus();
                          });
                          
                        },
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pending",style: kBlackText,),
                          Text("Shipped",style:kBlackText),
                          Text("Delivered",style: kBlackText,)
                        ],
                      )
                    ]),
              ));
  }
}
