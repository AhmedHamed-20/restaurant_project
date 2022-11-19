import 'package:equatable/equatable.dart';

import 'order_content_model.dart';

class OrdersModel extends Equatable {
  final List<OrderContentModel> ordersContent;
  final int totalPrice;
  final String customerName;
  final String customerPhoneNumber;
  final String customerAddress;
  final String customeEmail;
  final String id;

  const OrdersModel(
      {required this.ordersContent,
      required this.totalPrice,
      required this.customerName,
      required this.customerPhoneNumber,
      required this.customerAddress,
      required this.customeEmail,
      required this.id});

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      ordersContent: (json['orderContent'] as List)
          .map((e) => OrderContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      customerName: json['customerName'] as String,
      customerPhoneNumber: json['customerPhoneNumber'] as String,
      customerAddress: json['customerAddress'] as String,
      customeEmail: json['customerEmail'] as String,
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
