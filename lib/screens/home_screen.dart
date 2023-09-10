import 'package:auction_fire/screens/login_page.dart';
import 'package:auction_fire/screens/user_main_func/add_product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   // id used to access pages of app 
  Widget selectedScreen = HomeScreen();

  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: Drawer(
        child: Container(
           height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFD45A2D),
                Color(0xFFBD861C),
                Color.fromARGB(67, 0, 130, 181)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ListView(
            children: [
              const DrawerHeader(
          child: Text('Drawer Header'),
              ),
               ListTile(
          title: const Text('Add Product'),
          onTap: () { 
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(), // Replace with your actual screen widget
              ),
              );
          },
              ),
            ],
          ),
        ),
     
      ),
     
     
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
       // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)), this is like a drawer in appbar 
        actions: <Widget>[
          //notice bell button
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          //profile button
          IconButton(
            onPressed: () {
            signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline_sharp,
                size: 30,
              ),
              alignment: Alignment.bottomRight,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
              alignment: Alignment.bottomCenter,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              alignment: Alignment.bottomLeft,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFD45A2D),
                Color(0xFFBD861C),
                Color.fromARGB(67, 0, 130, 181)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
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
                  
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                           margin: EdgeInsets.all(15),
                            child: Container(
                              height: 170, width: 130,
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "./images/apple_watch.png"))),
                                  ),
                                  Text(
                                    'Rs/= 1999',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    'Apple Watch',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              // decoration: BoxDecoration( color: Colors.amber[100],
                              //   image: DecorationImage(image: AssetImage("images/t_shirt.png"))
                              // ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Card(
                        margin: EdgeInsets.only(right: 15),
                        child: Container(
                          height: 170,
                          width: 140,
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "./images/t_shirt.png"))),
                              ),
                              Text(
                                'Rs/= 599',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                'Man Long T_Shirt',
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
  Widget MyDrawerList(){
  return Container();
}
}

