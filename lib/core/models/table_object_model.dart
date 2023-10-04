class TableObject {
  final int id;
  final String title;
  int quantity;
  final double price;
  final int subscribeId;

  TableObject({
    required this.id,
    required this.title,
    this.quantity = 1,
    required this.price,
    required this.subscribeId,
  });
}
