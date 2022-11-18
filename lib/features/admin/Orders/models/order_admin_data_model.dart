import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/Orders/models/order_content_model.dart';

class OrdersAdminDataModel extends Equatable {
  final List<OrderAdminContentModel> ordersContent;
  final int totalPrice;
  final String customerName;
  final String customerPhoneNumber;
  final String customerAddress;
  final String customeEmail;
  final String id;

  const OrdersAdminDataModel(
      {required this.ordersContent,
      required this.totalPrice,
      required this.customerName,
      required this.customerPhoneNumber,
      required this.customerAddress,
      required this.customeEmail,
      required this.id});

  factory OrdersAdminDataModel.fromJson(Map<String, dynamic> json) {
    return OrdersAdminDataModel(
      ordersContent: (json['ordersContent'] as List)
          .map(
              (e) => OrderAdminContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      customerName: json['customerName'] as String,
      customerPhoneNumber: json['customerPhoneNumber'] as String,
      customerAddress: json['customerAddress'] as String,
      customeEmail: json['customeEmail'] as String,
      id: json['_id'] as String,
    );
  }
  @override
  List<Object?> get props => [
        ordersContent,
        totalPrice,
        customerName,
        customerPhoneNumber,
        customerAddress,
        customeEmail,
        id
      ];
}
