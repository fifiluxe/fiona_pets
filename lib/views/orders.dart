// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final List<Map<String, dynamic>> petData = const [
    {'product': 'Labrador Retriever', 'type': 'Dog', 'price': 104000.00},
    {'name': 'German Shepherd', 'type': 'Dog', 'price': 117000.00},
    {'name': 'Persian', 'type': 'Cat', 'price': 78000.00},
    {'name': 'Siamese', 'type': 'Cat', 'price': 65000.00},
    {'name': 'Comet Goldfish', 'type': 'Fish', 'price': 1950.00},
    {'name': 'Fantail Goldfish', 'type': 'Fish', 'price': 2600.00},
    {'name': 'African Grey', 'type': 'Parrot', 'price': 156000.00},
  ];

  String? selectedPet;
  int quantity = 1;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String bill = '';

  // Function to generate the bill
  void generateBill() {
    if (selectedPet == null ||
        nameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final pet = petData.firstWhere((p) => p['name'] == selectedPet);
    final totalCost = pet['price'] * quantity;

    setState(() {
      bill = '''
      === Order Bill ===
      Customer Name: ${nameController.text}
      Phone Number: ${phoneController.text}
      Pet: ${pet['name']} (${pet['type']})
      Quantity: $quantity
      Total Cost: KSh ${totalCost.toStringAsFixed(2)}
      ==================
      ''';
    });

    // Call submitOrder when bill is generated
    submitOrder(pet, totalCost);
  }

  // Function to submit the order to the server
  void submitOrder(Map<String, dynamic> pet, double totalCost) async {
    if (mounted) {
      // Proceed only if widget is still in the tree
      if (nameController.text.isEmpty || phoneController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
        return;
      }

      final petId = petData.indexOf(pet) + 1;

      final orderData = {
        'username': nameController.text,
        'phone_number': phoneController.text,
        'pet_id': petId.toString(),
        'quantity': quantity.toString(),
        'total_cost': totalCost.toString(),
      };
      // ignore: avoid_print
      print("Sending order data: $orderData");

      final response = await http.post(
        Uri.parse('http://192.168.16.121/petadoption/place_order.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: orderData,
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == 1) {
        // Handle success
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(responseData['message'])));
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message'] ?? 'Failed to place order'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Your Order'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const Text(
                'Pet Selection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedPet,
                hint: const Text('Select a Pet'),
                items:
                    petData.map((pet) {
                      return DropdownMenuItem<String>(
                        value: pet['name'],
                        child: Text(
                          '${pet['name']} - KSh ${pet['price'].toStringAsFixed(2)}',
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPet = value;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Quantity: ', style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  Text('$quantity', style: const TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateBill,
                child: const Text('Generate Bill'),
              ),
              const SizedBox(height: 20),
              if (bill.isNotEmpty)
                Text(
                  bill,
                  style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
