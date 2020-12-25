import 'package:berry/Classes/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:berry/Classes/product.dart';
import 'package:berry/Classes/cartProduct.dart';
import 'package:berry/Classes/category.dart';
import 'package:berry/Classes/order.dart';

List<CartProduct> cartProducts = [];
Customer currentCustomer;

class Database {
  Future<Customer> getCustomer(String email) async {
    Customer currentCustomer;
    try {
      final response = await http.post('http://10.0.2.2:5000/getCustomer',
          body: json.encode({"email": email}));

      currentCustomer = Customer.fromJson(json.decode(response.body));

      return currentCustomer;
    } catch (e) {
      print(e);
      return currentCustomer;
    }
  }

  Future<String> register(
      String name, String email, String number, String password) async {
    try {
      final response = await http.post('http://10.0.2.2:5000/addCustomer',
          body: json.encode(
            {
              'name': name,
              'email': email,
              'number': number,
              'password': password
            },
          ));
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }

  Future<String> loginINAdmin(String email, String password) async {
    try {
      final response = await http.post('http://10.0.2.2:5000/loginAdmin',
          body: json.encode(
            {'email': email, 'password': password},
          ));
      return response.body;
    } catch (e) {
      print('error');
      return "Network Error";
    }
  }

  Future<String> sendOTP(String email) async{
    try {
      final response = await http.post('http://10.0.2.2:5000/sendOTP',
          body: json.encode(
            {'email': email},
          ));
      return response.body;
    } catch (e) {
      print('error');
      return "Network Error";
    }
  }
  Future<String> loginIN(String email, String password) async {
    try {
      final response = await http.post('http://10.0.2.2:5000/login',
          body: json.encode(
            {'email': email, 'password': password},
          ));
      return response.body;
    } catch (e) {
      print('error');
      return "Network Error";
    }
  }

Future<List<Category>> getCategories() async{
  List<Category> ps = [];
    try {
      final response = await http.get('http://10.0.2.2:5000/getCategories');

      List p = jsonDecode(response.body);

      ps = p.map((json) => Category.fromJson(json)).toList();

      return ps;
    } catch (e) {
      return ps;
    }
}
  Future<List<Product>> getProducts() async {
    List<Product> ps = [];
    try {
      final response = await http.get('http://10.0.2.2:5000/getProducts');

      List p = jsonDecode(response.body);

      ps = p.map((json) => Product.fromJson(json)).toList();

      return ps;
    } catch (e) {
      return ps;
    }
  }
  Future<String> deleteProduct(int id) async{
    try{
      final response= await http.post('http://10.0.2.2:5000/deleteProduct',body: jsonEncode({"product_id":id}));
      return response.body;
    }
    catch(e){
      print(e);
      return "Network Error";
    }
  }
  Future<List<CartProduct>> getCartProducts(int id) async {
    List<CartProduct> ps = [];
    try {
      final response = await http.post('http://10.0.2.2:5000/getCartProducts',
          body: json.encode({"order_id": id}));

      List p = jsonDecode(response.body);

      ps = p.map((json) => CartProduct.fromJson(json)).toList();

      return ps;
    } catch (e) {
      return ps;
    }
  }

  void addToCart(CartProduct crt) {
    for (var pr in cartProducts) {
      if (pr.product.id == crt.product.id) {
        pr.qty++;
        return;
      }
    }

    cartProducts.add(crt);
  }

  void removeFromCart(int index) {
    cartProducts[index].qty--;
    if (cartProducts[index].qty == 0) {
      cartProducts.removeAt(index);
    }
  }

  List<CartProduct> getCart() {
    return cartProducts;
  }

  void clearCart() {
    cartProducts.clear();
  }

  Future<String> createOrder(Order order) async {
    var a = cartProducts.map((e) => jsonEncode(e)).toList();
    try {
      final response = await http.post('http://10.0.2.2:5000/create_order',
          body: json.encode({
            "cust_id": order.custId,
            "order_date": order.orderDate,
            "status": order.status,
            "amount": order.amount,
            "delivery_address": order.deliveryAdress,
            'products': a
          }));

          if(response.statusCode!=200)
          throw Exception("Network Error");

      return response.body;
    } catch (e) {
      print(e);
      return "Network Error";
    }
  }

  Future<List<Order>> getOrdersAdmin() async {
    List<Order> orders = [];
    try {
      final response = await http.get('http://10.0.2.2:5000/getOrders');

      List p = jsonDecode(response.body);

      orders = p.map((json) => Order.fromJson(json)).toList();

      return orders;
    } catch (e) {
      print(e);
      return orders;
    }
  }

  Future<String> getCustName(int id) async {
    try {
      final response = await http.post("http://10.0.2.2:5000/getCustName",
          body: jsonEncode({"cust_id": id}));

      return response.body;
    } catch (e) {
      print(e);
      return "Customer Name";
    }
  }

  Future<String> updateStatus(String status,int id) async {
    try {
      final response = await http.post("http://10.0.2.2:5000/updateStatus",
          body: jsonEncode({"status": status,"o_id":id}));

      return response.body;
    } catch (e) {
      print(e);
      return "Error";
    }
  }
   Future<String> updateQty(int qty,int id) async {
    try {
      final response = await http.post("http://10.0.2.2:5000/updateQty",
          body: jsonEncode({"qty": qty,"product_id":id}));

      return response.body;
    } catch (e) {
      print(e);
      return "Error";
    }
  }
   Future<String> updatePrice(int price,int id) async {
    try {
      final response = await http.post("http://10.0.2.2:5000/updatePrice",
          body: jsonEncode({"unit_price": price,"product_id":id}));

      return response.body;
    } catch (e) {
      print(e);
      return "Error";
    }
  }

  Future<List<Order>> getOrders() async {
    List<Order> orders = [];
    try {
      final response = await http.post('http://10.0.2.2:5000/getOrders',
          body: json.encode({'cust_id': currentCustomer.id}));

      List p = jsonDecode(response.body);

      orders = p.map((json) => Order.fromJson(json)).toList();

      return orders;
    } catch (e) {
      print(e);
      return orders;
    }
  }

  Future<String> addProduct(Product product) async {
   
    try {
      final response = await http.post("http://10.0.2.2:5000/addProduct",
          body: json.encode(
            {
              "product_id": product.id,
              "product_name":product.name,
              "product_description":product.description,
              "unit_price":product.price,
              "company_name":product.company,
              "qty_in_stock":product.qtyInStock,
              "imglink":product.imgLink
            },
          ));

          return response.body;
    } catch (e) {
      print(e);
      return "Network Error";
    }
  }
}
