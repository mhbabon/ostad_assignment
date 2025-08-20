import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Pullover",
      "color": "Black",
      "size": "L",
      "price": 51,
      "quantity": 1, // ✅ added
      "image": "",
    },
    {
      "name": "T-Shirt",
      "color": "Gray",
      "size": "L",
      "price": 30,
      "quantity": 1, // ✅ added
      "image": "",
    },
  ];


  @override
  Widget build(BuildContext context) {
    int total = cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));


    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bag", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // ✅ Product Image
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                            image: item['image'] != ""
                                ? DecorationImage(
                              image: AssetImage(item['image']),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: item['image'] == ""
                              ? const Icon(Icons.image, size: 40, color: Colors.grey)
                              : null,
                        ),
                        const SizedBox(width: 12),

                        // ✅ Product Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'],
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("Color: ${item['color']}   Size: ${item['size']}"),
                            ],
                          ),
                        ),

                        // ✅ Price + Quantity Control
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${item['price']}\$",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => decreaseQuantity(index), icon: const Icon(Icons.remove)),
                                Text("${item['quantity']}",),
                                IconButton(
                                    onPressed: () => increaseQuantity(index), icon: const Icon(Icons.add)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ✅ Bottom Checkout Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade200, blurRadius: 5)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total amount:", style: TextStyle(fontSize: 16)),
                    Text("\$$total",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "🎉 Congratulations! Your order has been placed.",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                  const Text("CHECK OUT", style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),

    );

  }
  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

}
