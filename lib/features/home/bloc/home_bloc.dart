import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_event.dart';
import 'package:project_given_by_sayyam/features/home/bloc/home_states.dart';
import 'package:project_given_by_sayyam/features/home/model/product_model.dart';
import 'package:project_given_by_sayyam/loaderfunc.dart';

class product_bloc extends Bloc<product_event, product_State> {
  product_bloc() : super(product_State()) {
    on<load_product_event>((event, emit) async {
      if (state.products.isNotEmpty) return;

      emit(state.copyWith(isLoading: true));
      final data = await loaderfunc().load_products();
      final List<product_model> products = data
          .map((json) => product_model.fromJson(json))
          .toList();
      final filteredProducts = products
          .where(
            (product) => product.isSold == false && product.items_sold != 0,
          )
          .toList();

      emit(state.copyWith(products: filteredProducts, isLoading: false));
    });

    on<load_add_to_cart_products>((event, emit) {
      final cartproducts = state.products
          .where((product) => product.addedToCart == true)
          .toList();

      emit(state.copyWith(cartproducts: cartproducts));
    });

    on<remove_from_cart_item>((event, emit) {
      final updatedProducts = state.products.map((product) {
        if (product.id == event.id) {
          return product.copyWith(addedToCart: false, items_sold: 1);
        }
        return product;
      }).toList();

      final updatedCart = updatedProducts
          .where((product) => product.addedToCart == true)
          .toList();

      emit(
        state.copyWith(products: updatedProducts, cartproducts: updatedCart),
      );
    });
    on<reset_items_sold_event>((event, emit) {
      final updatedProducts = state.products.map((product) {
        if (product.addedToCart == true) {
          return product.copyWith(items_sold: 1);
        }
        return product;
      }).toList();

      emit(state.copyWith(products: updatedProducts));
    });
    on<pay_now_event>((event, emit) {
      final updatedproducts = state.products.map((product) {
        if (product.addedToCart == true) {
          final int sold = product.items_sold ?? 1;
          final int remaining = product.quantity - sold;
          if (remaining <= 0) {
            // All stock gone — mark as fully sold
            return product.copyWith(isSold: true, addedToCart: false, items_sold: 1);
          } else {
            // Partial purchase — reduce quantity, keep visible on home
            return product.copyWith(addedToCart: false, quantity: remaining, items_sold: 1);
          }
        }
        return product;
      }).toList();
      emit(state.copyWith(products: updatedproducts, cartproducts: []));
    });
    on<add_to_cart_event>((event, emit) {
      final updatedProducts = state.products.map((product) {
        if (product.id == event.id) {
          return product.copyWith(
            addedToCart: true,
            quantity_added_for_cart: event.quantity,
          );
        }
        return product;
      }).toList();
      debugPrint(updatedProducts.toString());
      emit(state.copyWith(products: updatedProducts, count: 1));
    });
    on<buy_now_event_for_ind_product>((event, emit) {
      final updatedproducts = state.products.map((product) {
        if (product.id == event.id) {
          return product.copyWith(isSold: true, addedToCart: false);
        }
        return product;
      }).toList();
      final availableproducts = updatedproducts.where((product) {
        return product.isSold == false;
      }).toList();
      final updatedcart = availableproducts.where((product) {
        return product.addedToCart == true;
      }).toList();
      emit(
        state.copyWith(products: availableproducts, cartproducts: updatedcart),
      );
    });
    on<total_amount>((event, emit) {
      final cartproducts = state.cartproducts;
      product_model item;
      int amount = 0;
      for (int i = 0; i < cartproducts.length; i++) {
        item = cartproducts[i];
        int quantity = item.items_sold ?? 1;
        int price = item.price * quantity;
        amount = amount + price;
      }
      emit(state.copyWith(amount: amount));
    });
    on<increment_quantity_event>((event, emit) {
      final updatedproducts = state.products.map((product) {
        if (event.id == product.id) {
          final int no = product.items_sold ?? 0;
          return product.copyWith(items_sold: no + 1);
        }
        return product;
      }).toList();

      if (event.quantity > event.itemsold) {
        emit(
          state.copyWith(
            products: updatedproducts,
            cartproducts: updatedproducts
                .where((p) => p.addedToCart == true)
                .toList(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Only this much quantity is available");
      }
    });

    on<decrement_quantity_event>((event, emit) {
      final updatedproducts = state.products.map((product) {
        if (event.id == product.id) {
          final int no = product.items_sold ?? 0;
          return product.copyWith(items_sold: no - 1);
        }
        return product;
      }).toList();

      if (event.itemsold > 1) {
        emit(
          state.copyWith(
            products: updatedproducts,
            cartproducts: updatedproducts
                .where((p) => p.addedToCart == true)
                .toList(),
          ),
        );
      }

      return;
    });
  }
}
