import 'package:crudapplivcation/ui/model/Product.dart';
import 'package:crudapplivcation/ui/screens/Update_Product_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudapplivcation/ui/widgets/custom_network_image.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onDeleteTab;
  
  const ProductItem({
    super.key,
    required this.product,
    this.onDeleteTab,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: isDark 
                ? [Colors.grey[900]!, Colors.grey[800]!]
                : [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomNetworkImage(
                  imageUrl: product.image ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(product.productName ?? 'Unknown'.tr),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${'code'.tr}: ${product.productCode ?? 'Unknown'.tr}'),
                          Text('${'quantity'.tr}: ${product.quantity ?? '0'}'),
                          Text('${'price'.tr}: ${product.unitPrice ?? '0'}'),
                          Text('${'total_price'.tr}: ${product.totalPrice ?? '0'}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Action Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed(UpdateProductScreen.name, arguments: product);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                  IconButton(
                    onPressed: onDeleteTab,
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
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

