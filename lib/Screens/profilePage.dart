import 'package:berry/Classes/customer.dart';
import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'ordersPage.dart';

class ProfilePage extends StatelessWidget {
  final Customer currentCustomer;
  ProfilePage(this.currentCustomer);
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            SizedBox(height: 30),
            Center(child: CircleAvatar(radius:30.0,child: Text(currentCustomer.name[0],style:kTextStyle2))),
            SizedBox(height: 12.0,),
            Center(child: Text(currentCustomer.name,style: titleTextStyle)),
            SizedBox(height:12.0),
            Divider(),
            SizedBox(height:20.0),
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width :10),
                Text(currentCustomer.email,style: kTextStyle2),
              ],
            ),
            SizedBox(height:12.0),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width :10),
                Text(currentCustomer.phoneNumber,style: kTextStyle2),
              ],
            ),
            SizedBox(height:12.0),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersPage()));
              },
                          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text("My Orders",style:kTextStyle2),
                  Icon(Icons.arrow_forward_ios),
                ]
              ),
            )
          ]
        ),
      );
  }
}
