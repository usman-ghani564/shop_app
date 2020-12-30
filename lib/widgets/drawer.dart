import 'package:flutter/material.dart';

import '../screens/user_products.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello friends!'),
            automaticallyImplyLeading: false,
          ),
          InkWell(
            splashColor: Colors.grey[650],
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.shop),
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
              title: Text('Shop'),
            ),
          ),
          Divider(),
          InkWell(
            splashColor: Colors.grey[650],
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(OrderScreen.routeName);
                },
              ),
              title: Text('Orders'),
            ),
          ),
          Divider(),
          InkWell(
            splashColor: Colors.grey[650],
            onTap: () {
              Navigator.of(context).pushNamed(UserProductsScreen.routeName);
            },
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(OrderScreen.routeName);
                },
              ),
              title: Text('Manage Products'),
            ),
          ),
        ],
      ),
    );
  }
}
