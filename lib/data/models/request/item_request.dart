class ItemRequest {
  final String itemNo;
  final String itemName;
  final int qty;
  final double pricePerUnit;

  ItemRequest({
    required this.itemNo,
    required this.itemName,
    required this.qty,
    required this.pricePerUnit
  });

  Map<String, dynamic> toMap() {
    return {
      "itemNo": itemNo,
      "itemName": itemName,
      "qty": qty,
      "pricePerUnit": pricePerUnit
    };
  }

}