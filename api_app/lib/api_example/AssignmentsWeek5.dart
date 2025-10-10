import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ProductFormPage.dart';

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  List<Product> ProductList = [];

  @override
  void initState() {
    super.initState();
    fetchAllUser();
  }

  void fetchAllUser() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:8001/products'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          ProductList = jsonList.map((item) => Product.fromJson(item)).toList();
        });
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading products'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void deleteProduct(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('http://localhost:8001/products/$id'),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        fetchAllUser();
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting product'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showDeleteDialog(int id, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete "$name"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteProduct(id);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void navigateToForm({Product? product}) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductFormPage(product: product),
      ),
    );
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(product == null
              ? 'Product created successfully'
              : 'Product updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      fetchAllUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Product'),
        actions: [
          IconButton(
            onPressed: () {
              fetchAllUser();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: ProductList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: ProductList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${ProductList[index].id}'),
                  ),
                  title: Text('${ProductList[index].name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${ProductList[index].description}'),
                      Text(
                        'Price: ${ProductList[index].price}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          navigateToForm(product: ProductList[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDeleteDialog(
                            ProductList[index].id,
                            ProductList[index].name,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToForm();
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;

  Product(this.id, this.name, this.description, this.price);

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'];
}