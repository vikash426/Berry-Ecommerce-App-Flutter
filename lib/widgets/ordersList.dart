import 'package:berry/Classes/order.dart';
import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
class OrdersList extends StatelessWidget {
  
  final Function onPress;
  final List<Order> orders;
  OrdersList({this.orders,this.onPress});

  Color getC(String status) {
    if (status == "Pending")
      return Colors.red[400];
    else if (status == "Shipped")
      return Colors.blue[400];
    else
      return Colors.green[400];
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                            
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    onPress(index);
                  },
                    child: ListTile(
               
                    title: Text(
                      "ORDER# ${orders[index].orderId}",
                      style: priceTextStyle,
                    ),
                    subtitle: Text(orders[index].orderDate,style:TextStyle(fontSize: 17.0)),
                    trailing: Column(children: [
                      Text(
                        "Rs. ${orders[index].amount}",
                        style: productPriceTextStyle,
                      ),
                      SizedBox(height:8.0),
                      Container(
                          decoration: BoxDecoration(
                              color: getC(orders[index].status),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              orders[index].status,
                              style: textStyle,
                            ),
                          ))
                    ]),
                  ),
                ),
                itemCount: orders.length,
                separatorBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0),
                  child: Divider(color:Colors.black),
                ),
              );
  }
}