import 'dart:io';

import 'package:exam/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/global.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController txtPname = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  String productPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: const Text(
          "Add Item",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: productKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.sizeOf(context).width * 0.90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${g1.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "${g1.id}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "${g1.phone}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    productPath.isEmpty
                        ? const CircleAvatar(
                            radius: 50,
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(
                              File(productPath),
                            ),
                          ),
                    InkWell(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          productPath = image!.path;
                        });
                      },
                      child: const CircleAvatar(
                        radius: 15,
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

                        g1.product.add(detail);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Save"),

                          ),
                        );
                        Navigator.pop(context);
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
        ),
      ),
    );
  }
}
