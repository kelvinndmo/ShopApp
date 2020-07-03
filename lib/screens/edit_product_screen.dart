import 'package:flutter/material.dart';
import 'package:shopping/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_products';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', price: null, description: '', imageUrl: '');

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(__updateImage);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': ''
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void __updateImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProducts(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(__updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: value,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        isFavourite: _editedProduct.isFavourite,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id);
                  },
                  onFieldSubmitted: (_) =>
                      {FocusScope.of(context).requestFocus(_priceFocusNode)},
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a price";
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value),
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        isFavourite: _editedProduct.isFavourite,
                        id: _editedProduct.id);
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode)
                  },
                  focusNode: _priceFocusNode,
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a description";
                    }
                    if (value.length < 10) {
                      return 'Value must be greater than 10';
                    }

                    return null;
                  },
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: value,
                        isFavourite: _editedProduct.isFavourite,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id);
                  },
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a url')
                          : Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.fill,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter  a url';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'please enter a valid URL';
                            }
                            // if (!value.endsWith('.png') &&
                            //     !value.endsWith('.jpg') &&
                            //     !value.endsWith('jpeg')) {
                            //   return 'Please enter a valid image url';
                            // }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: value,
                                isFavourite: _editedProduct.isFavourite,
                                id: _editedProduct.id);
                          },
                          decoration: InputDecoration(
                            labelText: 'Image Url',
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) => _saveForm(),
                          focusNode: _imageUrlFocusNode),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
