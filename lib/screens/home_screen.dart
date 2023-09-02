import 'package:auction_fire/screens/user_main_func/add_product_screen.dart';
import 'package:auction_fire/widgets/bid_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   // id used to access pages of app 
  Widget selectedScreen = HomeScreen();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
          color: Colors.blue,
        ),
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
    //  child: SingleChildScrollView(
    //   child: Container(
    //     child: Column(
    //       children: [
    //         const DrawerHeader(child: Text('WELCOME')),
    //         MyDrawerList(),
    //       ],
    //     ),
    //   ),
    //  ),
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
            onPressed: () {},
            icon: Icon(Icons.circle_outlined),
          ),
        ],
      ),
    
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline_sharp,
                size: 30,
              ),
              alignment: Alignment.bottomRight,
            ),
            Padding(padding: EdgeInsets.only(right: 105)),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
              alignment: Alignment.bottomCenter,
            ),
            Padding(padding: EdgeInsets.only(left: 105)),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const  backGroundcolor(),
            Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(colors: [
              //   Color(0xFFD45A2D),
              //   Color(0xFFBD861C),
              //   Color.fromARGB(67, 0, 130, 181)
              // ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
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
                        children: [
                          Card(
                            margin: EdgeInsets.only(left: 15),
                            child: Container(
                              height: 170, width: 170,
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 110,
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
                        width: 20,
                      ),
                      Card(
                        child: Container(
                          height: 170,
                          width: 170,
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                width: 110,
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

