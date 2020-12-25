
class Order{
  int orderId;
  int custId;
  String orderDate;
  String status;
  int amount;
  String deliveryAdress;

  Order({this.orderId=0,this.custId,this.orderDate,this.status,this.amount,this.deliveryAdress});

  factory Order.fromJson(Map<String, dynamic> json)
  {
    return Order(
    orderId:json['order_id'] as int,  
    custId:json['cust_id'] as int,
    orderDate:json['order_date'] as String,
    status:json['status'] as String,
    amount:json['amount'] as int,
    deliveryAdress: json['delivery_address'] as String
    );
    }
  

}