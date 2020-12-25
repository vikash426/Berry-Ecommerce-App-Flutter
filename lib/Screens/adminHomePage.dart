import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'package:berry/widgets/ordersList.dart';
import 'package:berry/Classes/order.dart';
import 'package:berry/Services/Database.dart';
import 'package:berry/Screens/adminOrderDetails.dart';
import 'package:berry/Screens/adminProductsPage.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Order> orders;
  bool got = true;

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  void getOrders() async {
    orders = await Database().getOrdersAdmin();
    //custName = await Database().getCustName(orders);

    setState(() {
      got = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Orders", style: kTextStyle1),
        actions: [
          FlatButton(
            onPressed: null,
            child: FlatButton(
              child: Icon(Icons.view_list),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminProductsPage()));
              },
            ),
          )
        ],
      ),
      body: got
          ? CircularProgressIndicator()
          : OrdersList(
              orders: orders,
              onPress: (int ind) async{
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminOrderDetails(orders[ind])));
                        setState(() {
                          getOrders();
                        });
              },
            ),
    );
  }
}
