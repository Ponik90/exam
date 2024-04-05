import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/product_model.dart';
import '../../utils/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtPname = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  String productPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'bill');
            },
            icon: const Icon(
              Icons.copy,
              color: Colors.white,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                'person',
              ).then((value) {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: g1.product.length,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(
                    File("${g1.product[index].image}"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product : ${g1.product[index].pName}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Price : ${g1.product[index].price}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Qty : ${g1.product[index].qty}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      g1.product.removeAt(index);
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      update(index);
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 25,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'edit').then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  void update(int index) {
    productPath = g1.product[index].image!;
    txtPname.text = g1.product[index].pName!;
    txtPrice.text = g1.product[index].price!;
    txtQty.text = g1.product[index].qty!;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: productKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          productPath.isEmpty
                              ? const CircleAvatar(
                                  radius: 30,
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: FileImage(
                                    File(productPath),
                                  ),
                                ),
                          InkWell(
                            onTap: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                productPath = image!.path;
                              });
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.blueAccent,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Product",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Product Name";
                          }
                          return null;
                        },
                        controller: txtPname,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Price",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Product Name";
                          }
                          return null;
                        },
                        controller: txtPrice,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Qty",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the Product Qty";
                          }
                          return null;
                        },
                        controller: txtQty,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          if (productKey.currentState!.validate()) {
                            if (productPath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Enter the image"),
                                ),
                              );
                            } else {
                              ProductModel detail = ProductModel(
                                image: productPath,
                                pName: txtPname.text,
                                price: txtPrice.text,
                                qty: txtQty.text,
                              );

                              g1.product[index] = detail;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Save"),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: Colors.blueAccent,
                          alignment: Alignment.center,
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    ).then((value) {
      setState(() {});
    });
  }
}
