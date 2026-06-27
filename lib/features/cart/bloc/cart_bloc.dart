// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_given_by_sayyam/features/cart/bloc/cart_event.dart';
// import 'package:project_given_by_sayyam/features/cart/bloc/cart_state.dart';

// import 'package:project_given_by_sayyam/loaderfunc.dart';

// class cart_bloc extends Bloc<cart_event, cart_state> {
//   cart_bloc() : super(cart_state()) {
//     on<load_cart>((event, emit) async {
//       if (state.products.isNotEmpty) return;
//       emit(state.copyWith(isLoading: true));
//       final data = await loaderfunc().load_products();
//       final cart_items = data
//           .where((item) => item["added_to_cart"] == true)
//           .toList();
//       emit(state.copyWith(products: cart_items, isLoading: false));
//     });
  
  
//   }
// }
