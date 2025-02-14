import 'dart:convert';

import 'package:crudapplivcation/ui/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:crudapplivcation/ui/widgets/custom_text_field.dart';


class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update-product';

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update_product'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                label: 'product_name'.tr,
                hint: 'please_enter_product_name'.tr,
                controller: _nameTEController,
                prefixIcon: Icons.shopping_bag,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_product_name'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'product_code'.tr,
                hint: 'please_enter_product_code'.tr,
                controller: _codeTEController,
                prefixIcon: Icons.qr_code,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_product_code'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'price'.tr,
                hint: 'please_enter_price'.tr,
                controller: _priceTEController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.attach_money,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_price'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'total_price'.tr,
                hint: 'please_enter_total_price'.tr,
                controller: _totalPriceTEController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.price_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_total_price'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'quantity'.tr,
                hint: 'please_enter_quantity'.tr,
                controller: _quantityTEController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.inventory,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_quantity'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'image_url'.tr,
                hint: 'please_enter_image_url'.tr,
                controller: _imageTEController,
                prefixIcon: Icons.image,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_image_url'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: !_updateProductInProgress,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: _updateProduct,
                    child: Text('update_product'.tr),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});

    final Map<String, dynamic> inputData = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
    };

    final response = await http.post(
      Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(inputData),
    );

    _updateProductInProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Product updated successfully');
      Get.back();
    } else {
      Get.snackbar('Error', 'Failed to update product');
    }
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