import 'package:salaya_delivery_app/data/models/request/item_request.dart';

class CheckoutRequest {

  final String customerName;
  final String customerPhone;
  final String address;
  final String? customerComment;
  final String shipTo;
  final String branchShipping;
  final List<ItemRequest> items;

  CheckoutRequest({
    required this.customerName,
    required this.customerPhone,
    required this.address,
    this.customerComment,
    required this.shipTo,
    required this.branchShipping,
    required this.items
  });

  Map<String, dynamic> toMap() {
    return {
      "customerName": customerName,
      "customerPhone": customerPhone,
      "address": address,
      "customerComment": customerComment,
      "shipTo": shipTo,
      "branchShipping": branchShipping,
      "items": items.map((item) => item.toMap()).toList()
    };
  }

}