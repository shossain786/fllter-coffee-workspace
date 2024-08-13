import 'package:filtercoffee/img_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer {
  static getDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.deepPurple],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: ListView(
          children: [
            DrawerHeader(child: Image.asset(ImageList.appLogo)),
            ListTile(
              onTap: () {
                Navigator.pop(context);// close the drawer
                Navigator.pushReplacementNamed(context, '/dashboard-screen');
              },
              leading: const Icon(
                Icons.home,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 35,
                color: Colors.white,
              ),
            ),
            ExpansionTile(
              shape: Border.all(color: Colors.transparent),
              collapsedShape: null,
              leading: const Icon(
                CupertinoIcons.person_3_fill,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "Customers",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.person_add,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Add Customer",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.list,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Customers List",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
