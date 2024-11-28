import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'dashboard_screen.dart';

class WebMainScreen extends StatefulWidget {
  static const String id = "webmain";
  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  // id used to access pages of app
  Widget selectedScreen = DashboardScreen();

  // const WebMainScreen({super.key});
  // ignore: non_constant_identifier_names
  // ChooseScreen(item) {
  //   switch (item.route) {
  //     case DashboardScreen.id:
  //       setState(() {
  //         selectedScreen = DashboardScreen();
  //       });
  //       break;

  //     case AddProduct.id:
  //       setState(() {
  //         selectedScreen = AddProduct();
  //       });
  //       break;

  //     case DeleteProduct.id:
  //       setState(() {
  //         selectedScreen = DeleteProduct();
  //       });
  //       break;

  //     case UpdateProduct.id:
  //       setState(() {
  //         selectedScreen = UpdateProduct();
  //       });
  //       break;
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("ADMIN"),
          // backgroundColor: Colors.black
        ),
        // sideBar: SideBar(
        //     backgroundColor: Colors.cyan,
        //     textStyle: const TextStyle(fontSize: 14),
        //     onSelected: (item) {
        //       ChooseScreen(item);
        //     },
        //     items: const [
        //       AdminMenuItem(
        //         title: "DASHBOARD",
        //         icon: Icons.dashboard,
        //         route: DashboardScreen.id,
        //       ),
        //       AdminMenuItem(
        //         title: "ADD PRODUCTS",
        //         icon: Icons.add,
        //         route: AddProduct.id,
        //       ),
        //       AdminMenuItem(
        //         title: "UPDATE PRODUCTS",
        //         icon: Icons.update,
        //         route: UpdateProduct.id,
        //       ),
        //       AdminMenuItem(
        //         title: "DELETE PRODUCTS",
        //         icon: Icons.delete,
        //         route: DeleteProduct.id,
        //       ),
        //       AdminMenuItem(
        //         title: "CART ITEMS",
        //         icon: Icons.shop,
        //       ),
        //     ],
        //     selectedRoute: WebMainScreen.id),
        body: selectedScreen);
  }
}
