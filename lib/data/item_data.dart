///[ItemData] is a data class that holds all the information about an item
class ItemData {
  final String? id;
  final String? imageUrl;
  final String? manufacturerName;
  final String? itemName;
  final String? itemType;
  final double? itemPrice;

  ItemData(
      {this.id,
      this.imageUrl,
      this.manufacturerName,
      this.itemName,
      this.itemType,
      this.itemPrice});
}
