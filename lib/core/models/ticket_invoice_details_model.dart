class AddTicketInvoiceDetailsRquestDtos {
  final int subsribeId;
  final int sparePartId;
  final int quantity;
  final double sparePartPrice;
  final int numberOfFreeQuantity;
  final int numberOPaiedQuantity;

  AddTicketInvoiceDetailsRquestDtos({
    required this.subsribeId,
    required this.sparePartId,
    required this.quantity,
    required this.sparePartPrice,
    required this.numberOfFreeQuantity,
    required this.numberOPaiedQuantity,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subsribeId': subsribeId,
      'sparePartId': sparePartId,
      'quantity': quantity,
      'sparePartPrice': sparePartPrice,
      'numberOfFreeQuantity': numberOfFreeQuantity,
      'numberOPaiedQuantity': numberOPaiedQuantity,
    };
  }
}
