import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String id = routeArgs['id'];
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .getProductById(id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              loadedProduct.title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            floating: true,
            expandedHeight: 200,
            flexibleSpace: Container(
              height: 230,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((ctx, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$${loadedProduct.price}',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.grey[600],
                        fontFamily: 'Anton'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        loadedProduct.description,
                        style: TextStyle(fontSize: 15),
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              );
            }, childCount: 1),
          )
        ],
      ),
    );
  }
}
