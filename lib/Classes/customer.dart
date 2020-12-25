class Customer{
  int id;
  String name,email, password, phoneNumber;
   Customer({this.id,this.name,this.email,this.password,this.phoneNumber});

   factory Customer.fromJson(Map<String, dynamic> json)
  {
    return Customer(
    id:json['cust_id'] as int,
    name:json['cust_name'] as String,
    email:json['cust_email'] as String,
    password:json['cust_password'] as String,
    phoneNumber:json['cust_phone_number'] as String
    );
  } 
}