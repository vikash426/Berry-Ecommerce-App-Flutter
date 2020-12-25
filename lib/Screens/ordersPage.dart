import 'package:flutter/material.dart';
import 'package:berry/Classes/order.dart';
import 'package:berry/Services/Database.dart';
import 'package:berry/widgets/ordersList.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> orders;
  bool got = true;


  @override
  void initState() {
    getOrders();
    super.initState();
  }

  void getOrders() async {
    orders = await Database().getOrders();
    setState(() {
      got = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: got
            ? CircularProgressIndicator()
            : OrdersList(orders:orders));
  }
}
