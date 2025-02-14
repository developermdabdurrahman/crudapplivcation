import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crudapplivcation/ui/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  static const String name = '/add-new-product';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_product'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'product_name'.tr,
                  hint: 'product_name'.tr,
                  controller: _nameTEController,
                  prefixIcon: Icons.shopping_bag,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'product_code'.tr,
                  hint: 'product_code'.tr,
                  controller: _codeTEController,
                  prefixIcon: Icons.qr_code,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product code'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'price'.tr,
                  hint: 'price'.tr,
                  controller: _priceTEController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.attach_money,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'total_price'.tr,
                  hint: 'total_price'.tr,
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.price_change,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter total price'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'quantity'.tr,
                  hint: 'quantity'.tr,
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.inventory,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter quantity'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'image_url'.tr,
                  hint: 'image_url'.tr,
                  controller: _imageTEController,
                  prefixIcon: Icons.image,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter image URL'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: !_addNewProductInProgress,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addNewProduct();
                        }
                      },
                      child: Text('add_product'.tr),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewProduct() async {
    _addNewProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');

    Map<String, dynamic> requestBody = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };

    http.Response response = await http.post(
      uri,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);
    _addNewProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('product_added'.tr),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('product_add_failed'.tr),
        ),
      );
    }
  }

  void _clearTextFields() {
    _nameTEController.clear();
    _codeTEController.clear();
    _priceTEController.clear();
    _totalPriceTEController.clear();
    _imageTEController.clear();
    _quantityTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _quantityTEController.dispose();
    super.dispose();
  }
}