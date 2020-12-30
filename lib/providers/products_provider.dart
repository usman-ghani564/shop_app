import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    /*Product(
      id: 'p1',
      title: 'Red Shirt',
      description:
          'A red shirt - it is pretty red! Toward the end of the Middle Ages, when clothing became rather closely fitted, the shirt gradually increased in importance. During the 14th century, shirts worn by the Normans developed a neckband and cuffs. By the end of the 15th century, shirts were made in a variety of fabrics, such as wool, linen, and sometimes silk, for royalty.Shirts began to be embellished with embroidery, lace, and frills in the 16th century, and men’s outer garments—the doublet, or jacket—had a low neckline so that the shirt showed across the chest. By the end of that century, the shirt frill had developed into the ruff, which was a mark of the aristocracy. A law, in fact, was passed in England that forbade persons without social rank from wearing elaborately decorated shirts. At the beginning of the 17th century, the doublet had become so short that the ruffled shirt was visible between it and the breeches. The new style of men’s dress initiated in 1666, when Charles II of England adopted the long waistcoat, however, covered up most of the shirt. In the late 18th and early 19th centuries, the neckcloth was so elaborate and voluminous that the valet of English dandy Beau Brummell sometimes spent a whole morning getting it to sit properly. Brummell set the mode in 1806 for the ruffled shirt for both day and evening wear. Men’s clothing became more sombre in the Victorian age. High neckcloths were abandoned for collars and ties more or less the same as those worn in the 20th and 21st centuries. Men’s shirts in the 1960s were made in a variety of stripes, patterns, and colours previously not worn. In the 20th century, women’s shirts were made on lines similar to men’s, though they usually included darts in the back and in the front to make them more form-fitting.',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Protien Shake',
      description:
          'A nice protien that everyone needs. Protein is essential for muscle growth. Many athletes and gym enthusiasts consume protein shakes because they believe that these drinks will help them bulk up after strength training.A 2018 analysis of 49 studies supports the use of protein supplementation for this purpose. The research suggests that protein supplements significantly improve muscle size and strength in healthy adults who perform resistance exercise training, such as lifting weights.Protein supplementation was equally effective in men and women. However, the effectiveness may decrease with age, as older adults have higher protein requirements than younger people. The researchers also noted that once protein exceeded 1.6 grams (g) per kilogram (kg) of body weight (or 0.73 g per pound (lb) of body weight), the participants did not experience any additional benefits. The recommended daily intake of protein for people aged 19 years and over is 46 g for women and 56 g for men.People who find it challenging to meet these amounts, possibly including some vegans and vegetarians, may find that protein powder offers an easy solution to the problem.Athletes, weight lifters, older adults, and people with a chronic illness may need to exceed the general protein intake recommendation.Research shows that athletes with an intense training regimen may benefit from having about twice the daily recommended intake of protein, ranging from 1.4 to 2.0 g per kg of body weight. This is equivalent to 111–159 g per day for a person who weighs 175 lb.',
      price: 59.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfxh4rXjvoEl5fzrwk40T5kcJ3u1EQ30ayPw&usqp=CAU',
    ),
    Product(
      id: 'p3',
      title: 'IPHONE 12',
      description:
          'Newly released Iphone 12 series. While Apple staggered the iPhone 12 launch, all four models are now widely available. You can get them from your carrier, or unlocked from Apple, Amazon, Best Buy, and other retailers. In fact, over the few months that the iPhone 12 has been available, Counterpoint Research says it’s the bestselling 5G phone, and became so in its first two weeks of being available.The iPhone 12 Mini starts at \$699, and is the lineup’s small and affordable option. The iPhone 12 starts at \$799 and goes up to \$949 for the top storage option. We recommend opting for at least 128GB of storage.',
      price: 65.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw_MdwzTLrE_p-m4OZwbjilQqnJReeM_lsdw&usqp=CAU',
    ),
    Product(
      id: 'p4',
      title: 'Sony A7s iii',
      description:
          'Sony latest 4K mirror-less camera. The Sony a7s III can capture up to UHD 4K in 10-bit 4:2:2 at 120 frames per second (fps) at 280 megabits per second (Mb/s) in full-frame. If that wasn’t enough frames for you, it can shoot up to 240fps in HD; also in 4:2:2 10-Bit. It has two media card slots for either SD cards or the new CFexpress Type A cards. Don’t confuse this with the larger CFexpress Type B cards that share the XQD form factor. This new media allows for the top data rate when shooting at 280Mb/s.The camera comes with the far superior battery, shared with the a7R IV, but grows in size over the previous a7S II. Another exciting feature is the ability to output 16-bit RAW out the HDMI, though at the time of this review, there aren’t any external recorders that can capture it.Lastly, it has a fully articulating monitor, a first for the Sony Alpha line.',
      price: 500.69,
      imageUrl:
          'https://1.img-dpreview.com/files/p/TC4096x2731S4096x2731~sample_galleries/5089929548/9152468235.jpg',
    ),
    Product(
      id: 'p5',
      title: 'MacBook Air M1',
      description:
          'A newly released, highly fast macbook air with new M1 chip. As Apple put its own M1 chip inside, this is also the first MacBook Air to not be powered by an Intel processor. Apple’s new silicon is based on the 5-nanometer technology and has 16 billion transistors inside. While all that will read like Greek to an average reader, she just needs to know that this is most probably the most powerful processor with integrated graphics that has gone into a laptop ever. Apple’s new chip design means it is faster in processing machine learning and has a lower thermal footprint and hence offers double the battery life of an average laptop.',
      price: 6000,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzLgQQArbNBxTv4LBHHmd4Uxi7OgF3uIO2Ag&usqp=CAU',
    ),*/
  ];

  List<Product> get items {
    return [
      ..._items
    ]; //This will return a copy of _items list and not the originial reference to _items
  }

  List<Product> get favoriteItems {
    return _items.where((product) {
      return product.isFavorite;
    }).toList();
  }

  Product getProductById(String id) {
    return _items.firstWhere((item) {
      return item.id == id;
    });
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://shop-app-f9d30-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(new Product(
          id: prodID,
          description: prodData['description'],
          title: prodData['title'],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProducts(Product p) async {
    const url =
        'https://shop-app-f9d30-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': p.title,
            'description': p.description,
            'imageUrl': p.imageUrl,
            'price': p.price,
            'isFavorite': false,
          }));
      final newProduct = Product(
        title: p.title,
        imageUrl: p.imageUrl,
        price: p.price,
        description: p.description,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product p) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shop-app-f9d30-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': p.title,
            'description': p.description,
            'imageUrl': p.imageUrl,
            'price': p.price,
          }));
      _items[prodIndex] = p;
      notifyListeners();
    }
  }

  Future<void> removeProductById(String id) async {
    final productIndex = _items.indexWhere((prod) {
      return prod.id == id;
    });
    var existingProduct = _items[productIndex];
    _items.removeWhere((prod) {
      return prod.id == id;
    });
    notifyListeners();
    final url =
        'https://shop-app-f9d30-default-rtdb.firebaseio.com/products/$id.json';
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(productIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }
}
