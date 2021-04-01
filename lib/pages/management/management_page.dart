import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:demo_fllutter_cmdev/api/network_service.dart';
import 'package:demo_fllutter_cmdev/models/product_image.dart';
import 'package:demo_fllutter_cmdev/models/products.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  bool _isEdit;
  final _spacing = 12.0;
  Product _product;
  final _formKey = GlobalKey<FormState>();
  File _imageFile;

  @override
  void initState() {
    _isEdit = false;
    _product = Product();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // receive arguments
    final Object arguments = ModalRoute.of(context).settings.arguments;
    if (arguments is Product) {
      _isEdit = true;
      _product = arguments;
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildNameInput(),
                SizedBox(height: _spacing),
                Row(
                  children: [
                    Flexible(
                      child: _buildPriceInput(),
                      flex: 1,
                    ),
                    SizedBox(width: _spacing),
                    Flexible(
                      child: _buildStockInput(),
                      flex: 1,
                    ),
                  ],
                ),
                ProductImage(
                  callback,
                  _product.image,
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  callback(File imageFile) {
    this._imageFile = imageFile;
  }

  // # This method is for building appbar and submit button.
  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        _isEdit ? 'Edit Product' : 'Create Product',
      ),
      actions: [
        if (_isEdit) _buildDeleteButton(),
        // submit button
        TextButton(
          onPressed: () {
            print('Submit');
            _formKey.currentState.save();
            print(_product.name);
            print(_product.price);
            print(_product.stock);

            // dismiss keyboard
            FocusScope.of(context).requestFocus(FocusNode());

            // edit or add
            if (_isEdit) {
              editProduct();
            } else {
              addProduct();
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  // # This method is for building input name field.
  TextFormField _buildNameInput() => TextFormField(
        initialValue: _product.name,
        decoration: inputStyle('name'),
        keyboardType: TextInputType.text,
        onSaved: (newValue) {
          _product.name = newValue.isEmpty ? '-' : newValue;
        },
      );

  // # This method is for building input price field.
  TextFormField _buildPriceInput() => TextFormField(
        initialValue: _product.price?.toString(),
        decoration: inputStyle('price'),
        keyboardType: TextInputType.number,
        onSaved: (newValue) {
          _product.price = newValue.isEmpty ? 0 : int.parse(newValue);
        },
      );

  // # This method is for building input stock field.
  TextFormField _buildStockInput() => TextFormField(
        initialValue: _product.stock?.toString(),
        decoration: inputStyle('stock'),
        keyboardType: TextInputType.number,
        onSaved: (newValue) {
          _product.stock = newValue.isEmpty ? 0 : int.parse(newValue);
        },
      );

  // # This method is for setting inputStyle.
  InputDecoration inputStyle(label) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12, width: 2),
      ),
      labelText: label,
    );
  }

  // # This method is for calling NetworkService to add product.
  void addProduct() {
    NetworkService()
        .addProduct(_product, imageFile: _imageFile)
        .then((value) => {
              print(value),
              Navigator.pop(context),
              showAlertBar(value),
            })
        .catchError((e) {
      showAlertBar(
        e.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }

  // # This method is for showing alertbar.
  void showAlertBar(
    String message, {
    IconData icon = FontAwesomeIcons.checkCircle,
    Color color = Colors.green,
  }) {
    Flushbar(
      message: message,
      icon: FaIcon(
        icon,
        size: 28.0,
        color: Colors.green,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  _buildDeleteButton() {
    return IconButton(
      icon: Icon(Icons.delete_outline),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Product'),
            content: Text('Are you sure you are want to delete ?'),
            actions: [
              // cancel button
              TextButton(
                onPressed: () {
                  // dismiss
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              // ok button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteProduct();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void deleteProduct() {
    NetworkService()
        .delteProduct(_product.id)
        .then((value) => {
              print(value),
              Navigator.pop(context),
              showAlertBar(value),
            })
        .catchError((e) {
      showAlertBar(
        e.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }

  void editProduct() {
    NetworkService()
        .editProduct(_product, imageFile: _imageFile)
        .then((value) => {
              print(value),
              Navigator.pop(context),
              showAlertBar(value),
            })
        .catchError((e) {
      showAlertBar(
        e.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }
}
