import 'package:equatable/equatable.dart';

abstract class product_event extends Equatable {
  @override
  List<Object> get props => [];
}

class load_product_event extends product_event {}

class add_to_cart_event extends product_event {
  final int id;
  final int quantity;
  add_to_cart_event(this.id, this.quantity);
}

class load_add_to_cart_products extends product_event {}

class remove_from_cart_item extends product_event {
  final int id;
  remove_from_cart_item(this.id);
}

class increment_quantity_event extends product_event {
  final int quantity;
  final int itemsold;
  final int id;
  increment_quantity_event(this.quantity, this.itemsold, this.id);
}

class decrement_quantity_event extends product_event {
  final int id;
  final int itemsold;
  decrement_quantity_event(this.id, this.itemsold);
}

class reset_items_sold_event extends product_event {}

class pay_now_event extends product_event {}

class buy_now_event_for_ind_product extends product_event {
  final int id;
  buy_now_event_for_ind_product(this.id);
}

class total_amount extends product_event {

}

