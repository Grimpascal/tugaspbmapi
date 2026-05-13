import 'package:flutter/material.dart';
import '../controllers/product_controller.dart';

class tambahKatalog extends StatefulWidget {
  const tambahKatalog({super.key});

  @override
  State<tambahKatalog> createState() =>
      _tambahKatalogState();
}

class _tambahKatalogState
    extends State<tambahKatalog> {

  final ProductController productController =
      ProductController();

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      priceController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  bool isLoading = false;

  Future<void> addProduct() async {

    setState(() {
      isLoading = true;
    });

    bool success =
        await productController.addProduct(
      nameController.text,
      int.parse(priceController.text),
      descriptionController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Produk berhasil ditambahkan",
          ),
        ),
      );

      Navigator.pop(context, true);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Gagal menambahkan produk",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Tambah Produk",
        ),

        centerTitle: true,

        backgroundColor:
            const Color(0xFFEE4D2D),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nama Produk",
                hintText:
                    "Masukkan nama produk",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              keyboardType:
                  TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga",
                hintText:
                    "Masukkan harga produk",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller:
                  descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Deskripsi",
                hintText:
                    "Masukkan deskripsi produk",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : addProduct,
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFFEE4D2D,
                  ),
                ),

                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Tambah Produk",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}