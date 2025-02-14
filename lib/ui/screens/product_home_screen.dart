import 'package:crudapplivcation/ui/Widget/ProductItem.dart';
import 'package:crudapplivcation/ui/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudapplivcation/ui/controllers/theme_controller.dart';
import 'package:crudapplivcation/ui/widgets/app_drawer.dart';
import 'package:crudapplivcation/ui/controllers/product_controller.dart';
import 'package:crudapplivcation/ui/widgets/custom_network_image.dart';

class ProductListScreen extends GetView<ProductController> {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('products'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => Get.find<ThemeController>().showThemePickerDialog(),
          ),
          IconButton(
            onPressed: controller.getProductList,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return RefreshIndicator(
          onRefresh: controller.getProductList,
          child: ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return ProductItem(
                product: product,
                onDeleteTab: () => _deleteItemDialog(product, index),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-new-product'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteItemDialog(Product product, int index) {
    Get.dialog(
      AlertDialog(
        title: Text('delete_product'.tr),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('confirm_delete'.tr),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  leading: CustomNetworkImage(
                    imageUrl: product.image ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.productName ?? 'unknown'.tr),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'product_code'.tr}: ${product.productCode}'),
                      Text('${'quantity'.tr}: ${product.quantity}'),
                      Text('${'price'.tr}: ${product.unitPrice}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteProduct(product.id!, index);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
  }
}
