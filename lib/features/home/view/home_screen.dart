import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_bloc.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_event.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_states.dart';
import 'package:project_given_by_sayyam/features/home/widgets/book_card.dart';
import 'package:project_given_by_sayyam/features/home/widgets/product_details_pg.dart';
import 'package:project_given_by_sayyam/features/router.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<product_bloc>().add(load_product_event());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.goNamed(routesname.add_to_cart);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
        ],
      ),

      body: BlocBuilder<product_bloc, product_State>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Top of the Week",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products.where((p) => p.isSold == false && p.items_sold != 0).toList().length,
                    itemBuilder: (context, index) {
                      final product = state.products.where((p) => p.isSold == false && p.items_sold != 0 ).toList()[index];

                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                product_details_pg(product: product),
                          );
                        },
                        child: book_card(
                          image: product.image,
                          bookname: product.name,
                          bookprice: product.price.toString(),
                        ),
                      );
                    },
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
