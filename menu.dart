// Class for Menu Item
class Menu {
  Map<String, double> menuItems = {};

  void addMenuItem(String name, double price) {
    menuItems[name] = price;
  }

  void removeMenuItem(String name) {
    menuItems.remove(name);
  }

  double? getPrice(String name) {
    return menuItems[name];
  }

  void showMenu() {
    print('Menu');
    menuItems.forEach((name, price) {
      print('Item: $name, Price: \$${price.toStringAsFixed(2)}');
    });
  }
}