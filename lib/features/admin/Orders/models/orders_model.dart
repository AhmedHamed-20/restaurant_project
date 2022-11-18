import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/Orders/models/order_admin_data_model.dart';

class OrdersAdminModel extends Equatable {
  final int results;
  final List<OrdersAdminDataModel> ordersData;

  const OrdersAdminModel({required this.results, required this.ordersData});
  factory OrdersAdminModel.fromJson(Map<String, dynamic> json) {
    return OrdersAdminModel(
      results: json['results'] as int,
      ordersData: (json['data']['data'] as List)
          .map((e) => OrdersAdminDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [results, ordersData];
}
