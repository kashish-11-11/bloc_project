import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_bloc.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_event.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_states.dart';
import 'package:project_given_by_sayyam/features/cart/bloc/cart_bloc.dart';
import 'package:project_given_by_sayyam/features/cart/bloc/cart_event.dart';
import 'package:project_given_by_sayyam/features/home/model/product_model.dart';

class product_details_pg extends StatelessWidget {
  final product_model product;
  const product_details_pg({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<product_bloc, product_State>(
        builder: (BuildContext context, product_State state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Center(
                      child: Container(
                        height: 250,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(product.image, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Product Title
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Brand / Author
                    Text(
                      product.price.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.orange),
                    ),
                    const SizedBox(height: 10),

                    // Description
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<product_bloc>().add(
                                add_to_cart_event(product.id, state.count),
                              );
                              Fluttertoast.showToast(
                                msg: "Product added to cart successfully",
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add to bag',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<product_bloc>().add(
                                buy_now_event_for_ind_product(product.id),
                              );
                              Fluttertoast.showToast(
                                msg: "Product bought successfully",
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: const BorderSide(color: Colors.blue),
                            ),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
