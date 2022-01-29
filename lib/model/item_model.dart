class Item {
  late int id;
  late String name;
  late String cover;
  late String desc;
  late int price;

  Item.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    cover = jsonMap['cover'];
    desc = jsonMap['desc'];
    price = jsonMap['price'];
  }
}
