import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:project_given_by_sayyam/features/home/bloc/home_bloc.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_event.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_states.dart';
import 'package:project_given_by_sayyam/features/home/model/product_model.dart';
import 'package:project_given_by_sayyam/features/router.dart';

class my_bag extends StatefulWidget {
  const my_bag({super.key});

  @override
  State<my_bag> createState() => _my_bagState();
}

class _my_bagState extends State<my_bag> {
  @override
  void initState() {
    super.initState();
    context.read<product_bloc>().add(load_add_to_cart_products());
    // Intentionally left blank, state is driven by product_bloc globally.
    context.read<product_bloc>().add(total_amount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            context.read<product_bloc>().add(reset_items_sold_event());
            context.goNamed(routesname.home);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("My bag"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: BlocBuilder<product_bloc, product_State>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = state.cartproducts;
          final itemsCount = items.length;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            // Image
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(item.image ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Title + quantity
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.read<product_bloc>().add(
                                            decrement_quantity_event(item.id, item.items_sold ?? 0),
                                          );
                                          context.read<product_bloc>().add(total_amount());
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      SizedBox(width: 10),

                                      Text(item.items_sold.toString()),

                                      // Text(item["quantity"].toString()),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<product_bloc>().add(
                                            increment_quantity_event(
                                              item.quantity,
                                              item.items_sold ?? 0,
                                              item.id,
                                            ),
                                          );
                                          context.read<product_bloc>().add(total_amount());
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Price
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.price.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    context.read<product_bloc>().add(
                                      remove_from_cart_item(item.id),
                                    );
                                    context.read<product_bloc>().add(total_amount());
                                  },
                                  child: const Text(
                                    "Remove",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Divider(),
                Row(
                  children: [
                    Text("Total payment"),
                    Spacer(),
                    Text(state.amount.toString()),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 20),

                  child: Container(
                    width: 327,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<product_bloc>().add(pay_now_event());
                        Fluttertoast.showToast(
                          msg: "Payment done successfully",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
