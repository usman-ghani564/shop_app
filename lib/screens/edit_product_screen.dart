import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-page';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imagUrlFocusNode = FocusNode();
  final _imageController = TextEditingController();

  var _edittedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  final _formKey = GlobalKey<FormState>();

  var initValues = {
    'title': '',
    'description': '',
    'price': '',
  };

  var isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imagUrlFocusNode.addListener(_updateUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _edittedProduct =
            Provider.of<ProductsProvider>(context).getProductById(productId);
        initValues = {
          'title': _edittedProduct.title,
          'description': _edittedProduct.description,
          'price': _edittedProduct.price.toString(),
        };
        _imageController.text = _edittedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imagUrlFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _updateUrl() {
    if (!_imagUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void forEmptyUrl() {
    if (_imageController.text.isEmpty) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_edittedProduct.id != null) {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_edittedProduct.id, _edittedProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProducts(_edittedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('An error occured!'),
                content: Text('Something went wrong.'),
                actions: [
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _edittedProduct = Product(
                          id: _edittedProduct.id,
                          isFavorite: _edittedProduct.isFavorite,
                          title: value,
                          price: _edittedProduct.price,
                          imageUrl: _edittedProduct.imageUrl,
                          description: _edittedProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _edittedProduct = Product(
                          id: _edittedProduct.id,
                          isFavorite: _edittedProduct.isFavorite,
                          title: _edittedProduct.title,
                          price: double.parse(value),
                          imageUrl: _edittedProduct.imageUrl,
                          description: _edittedProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _edittedProduct = Product(
                          id: _edittedProduct.id,
                          isFavorite: _edittedProduct.isFavorite,
                          title: _edittedProduct.title,
                          price: _edittedProduct.price,
                          imageUrl: _edittedProduct.imageUrl,
                          description: value,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 15, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: _imageController.text.isEmpty
                              ? Text('Enter a Url')
                              : FittedBox(
                                  child: Image.network(
                                      _imageController.text.toString()),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageController,
                            focusNode: _imagUrlFocusNode,
                            onFieldSubmitted: (_) => _saveForm(),
                            onSaved: (value) {
                              _edittedProduct = Product(
                                id: _edittedProduct.id,
                                isFavorite: _edittedProduct.isFavorite,
                                title: _edittedProduct.title,
                                price: _edittedProduct.price,
                                imageUrl: value,
                                description: _edittedProduct.description,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
