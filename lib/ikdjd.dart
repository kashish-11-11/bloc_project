  // on<increment_quantity_event>((event, emit) {
  //     final updatedproducts = state.products.map((product) {
  //       if (event.id == product.id) {
  //         final int no = product.items_sold ?? 0;
  //         return product.copyWith(items_sold: no + 1);
  //       }
  //       return product;
  //     }).toList();
      
  //     final updatedCart = updatedproducts.where((p) => p.addedToCart == true).toList();
      
  //     int newCount = state.count;
  //     if (event.quantity > state.count) {
  //       newCount = state.count + 1;
  //     } else {
  //       Fluttertoast.showToast(msg: "Only this much quantity is available");
  //     }
      
  //     emit(state.copyWith(
  //       products: updatedproducts, 
  //       cartproducts: updatedCart, 
  //       count: newCount
  //     ));
  //   });






  //     on<decrement_quantity_event>((event, emit) {
  //     final updatedproducts = state.products.map((product) {
  //       if (event.id == product.id) {
  //         final int no = product.items_sold ?? 0;
  //         if (no > 0) {
  //           return product.copyWith(items_sold: no - 1);
  //         }
  //       }
  //       return product;
  //     }).toList();

  //     final updatedCart = updatedproducts.where((p) => p.addedToCart == true).toList();

  //     int newCount = state.count;
  //     if (state.count > 1) {
  //       newCount = state.count - 1;
  //     }
      
  //     emit(state.copyWith(
  //       products: updatedproducts, 
  //       cartproducts: updatedCart, 
  //       count: newCount
  //     ));
  //   });