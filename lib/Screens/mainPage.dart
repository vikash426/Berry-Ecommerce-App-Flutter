//import 'package:berry/Classes/cartProduct.dart';
import 'package:berry/Classes/product.dart';
import 'package:berry/Screens/profilePage.dart';
import 'package:berry/widgets/cartList.dart';
import 'package:flutter/material.dart';
import 'package:berry/widgets/productsGrid.dart';
import 'package:berry/Services/Database.dart';
import 'package:berry/Classes/customer.dart';
import 'package:berry/Screens/detailsPage.dart';
import 'package:berry/Classes/category.dart';
import 'package:berry/widgets/searchPage.dart';

class MainPage extends StatefulWidget {
  final Customer currentCustomer;
  MainPage(this.currentCustomer);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Category> categories;
  List<Product> products = [];
  List<Product> allProducts = [];
  String selectedCategory = "All";
  Category ct = Category(id: 0, name: "All");
  int _currentIndex = 0;
  List<Widget> _children = [
    Center(child: CircularProgressIndicator()),
    Center(child: CircularProgressIndicator()),
    Center(child: CircularProgressIndicator()),
    ProfilePage(currentCustomer),
  ];

  void onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Product> categ(int id) {
    List<Product> filtered = [];
    if (id == 0) return allProducts;
    for (var p in allProducts) {
      if (p.categoryID == id) {
        filtered.add(p);
      }
    }
    return filtered;
  }

  void reload() {
    setState(() {
      
      _children[0] = ProductGrid(
        topWidget: Container(
            height: 60,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool k = selectedCategory == categories[index].name;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index].name;
                        products = categ(categories[index].id);
                        reload();
                      });
                    },
                    child: Container(
                      child: Center(
                          child: Text(categories[index].name,
                              style: TextStyle(
                                  color: k ? Colors.white : Colors.black))),
                      margin: EdgeInsets.all(8.0),
                      width: 100,
                      decoration: BoxDecoration(
                          color: k ? Colors.red[300] : Colors.white,
                          border:
                              Border.all(color: Colors.red[300], width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  );
                })),
        products: products,
        onClick: (Product p) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetailsPage(p)));
        },
        w: (Product pr) {
          return SizedBox(height: 0.0);
        },
      );
      _children[1]=SearchPage(products);
      _children[2] = Cart();
    });
  }

  void getP() async {
    products = await Database().getProducts();
    categories = await Database().getCategories();
    allProducts = products;
    categories.insert(0, ct);
    reload();
  }

  @override
  void initState() {
    getP();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Berry'),
        actions: [Icon(Icons.account_circle)],
      ),
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
        iconSize: 30,
        onTap: onTapTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title:Text("Search")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
