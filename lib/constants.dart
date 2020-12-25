 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const TextStyle productTitleTextStyle=TextStyle( fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black);

const TextStyle productPriceTextStyle=TextStyle( fontSize: 18, fontWeight: FontWeight.bold);

const TextStyle titleTextStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

const TextStyle priceTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

const TextStyle kTextStyle1=TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kBlackText=TextStyle(color:Colors.black);
const kTextStyle2=TextStyle( fontSize: 18);

const TextStyle buttonTextStyle=TextStyle(fontSize: 30, color: Colors.white);

const textStyle=TextStyle(color:Colors.white);
var tempImage=Image.network("https://media.naheed.pk/catalog/product/cache/fd6f1e57839b9b324771e8de21428b3f/1/2/1202237-1.jpg");

String tempI="https://peoplemindshop.com/wp-content/uploads/2020/10/iphone12.jpg";



const ContainerDecoration = BoxDecoration(
  color:Color(0xFF9E9E9E),
  
   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  
);

const kTextFieldDecoration = InputDecoration(
  isDense: true,
  
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kshape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

Widget kButton({Function onPress,String txt}){
  return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                      onPressed: onPress,
                      color: Colors.black87,
                      shape: kshape,
                      child:Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(txt,style:buttonTextStyle.copyWith(fontSize:25.0)),
                      ),
                    ),
              );
}

