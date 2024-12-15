import 'package:crudapplivcation/ui/model/Product.dart';
import 'package:crudapplivcation/ui/screens/Update_Product_Screen.dart';
import 'package:flutter/material.dart';


class ProductItem extends StatelessWidget {
  Product product;
  VoidCallback? onDeleteTab;
  ProductItem({required this.product, this.onDeleteTab});



  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? '',
        width: 40,
      ),
      title: Text(product.productName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? 'Unknown'}'),
          Text('Quantity: ${product.quantity ?? 'Unknown'}'),
          Text('Price: ${product.unitPrice ?? 'Unknown'}'),
          Text('Total Price: ${product.totalPrice ?? 'Unknown'}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: onDeleteTab,
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {Navigator.pushNamed(context,UpdateProductScreen.name, arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }






}

