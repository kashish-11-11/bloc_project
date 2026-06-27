import 'package:equatable/equatable.dart';
import 'package:project_given_by_sayyam/features/home/model/product_model.dart';

class product_State extends Equatable {
  final List<product_model> products;
  final bool isLoading;
  final List<product_model> cartproducts;
  final int amount;
  final int count;

  const product_State({
    this.products = const [],
    this.isLoading = false,
    this.cartproducts = const [],
    this.amount = 0, // total amount on my bag

    this.count = 1,
  });

  product_State copyWith({
    List<product_model>? products,
    List<product_model>? cartproducts,
    bool? isLoading,
    int? amount,
    int? count,
  }) {
    return product_State(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      cartproducts: cartproducts ?? this.cartproducts,
      amount: amount ?? this.amount,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, cartproducts, amount, count];
}
