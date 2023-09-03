import 'package:auction_fire/screens/admin_screens/product_list.dart';
import 'package:auction_fire/screens/admin_screens/users_list.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const String id = "dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const backGroundcolor(),
            Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Welcome!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            margin: EdgeInsets.only(left: 15),
                            child: Container(
                              height: 170,
                              width: 170,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.supervised_user_circle),
                                    iconSize: 100,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserListScreen()));
                                    },
                                  ),
                                  Text(
                                    'Users List',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Card(
                        child: Container(
                          height: 170,
                          width: 170,
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                iconSize: 100,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductList()));
                                },
                              ),
                              Text(
                                'Products List',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
