import 'package:flutter/material.dart';
import 'package:tugaspbmapi/pages/tambahKatalog.dart';

import '../controllers/product_controller.dart';
import '../models/product_model.dart';

class katalogPage extends StatefulWidget {
  const katalogPage({super.key});

  @override
  State<katalogPage> createState() => _katalogPageState();
}

class _katalogPageState extends State<katalogPage> {

  final ProductController productController =
      ProductController();

  List<productModel> products = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchProducts();
  }

  Future<void> fetchProducts() async {

    try {

      final result =
          await productController.getProducts();

      setState(() {
        products = result;
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Katalog Produk",
        ),

        centerTitle: true,

        backgroundColor: const Color(
          0xFFEE4D2D,
        ),
      ),

      body: isLoading

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : products.isEmpty

              ? const Center(
                  child: Text(
                    "Belum ada produk",
                  ),
                )

              : RefreshIndicator(

                  onRefresh: fetchProducts,

                  child: ListView.builder(

                    padding: const EdgeInsets.all(16),

                    itemCount: products.length,

                    itemBuilder: (context, index) {

                      final product =
                          products[index];

                      return Card(

                        elevation: 4,

                        margin:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),

                        child: Padding(

                          padding:
                              const EdgeInsets.all(
                            16,
                          ),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                product.name,

                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Text(
                                "Rp ${product.price}",

                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  color:
                                      Colors.green,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Text(
                                product.description,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .end,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            const Color(0xFFEE4D2D),
        onPressed: () async {
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const tambahKatalog()));
          if(result== true){
            fetchProducts();
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}