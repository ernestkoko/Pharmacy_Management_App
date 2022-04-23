///[ItemData] is a data class that holds all the information about an item
class ItemData {
  final String id;
  final String imageUrl;
  final String manufacturerName;
  final String itemName;
  final String itemType;
  final double itemPrice;

  ItemData(
      { required this.id,
      required this.imageUrl,
      required this.manufacturerName,
      required this.itemName,
     required  this.itemType,
      required this.itemPrice});
}
