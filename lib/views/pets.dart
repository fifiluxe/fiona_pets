import 'package:flutter/material.dart';

class Pets extends StatelessWidget {
  const Pets({super.key});

  // Sample pet data with prices in Kenyan Shillings (KES)
  final List<Map<String, dynamic>> petData = const [
    {
      'name': 'Labrador Retriever',
      'type': 'Dog',
      'image': 'assets/images/labrador puppy.jpg',
      'price': 104000.00,
    },
    {
      'name': 'German Shepherd',
      'type': 'Dog',
      'image': 'assets/images/germanshepherd.jpg',
      'price': 117000.00,
    },
    {
      'name': 'Persian',
      'type': 'Cat',
      'image': 'assets/images/persian.jpg',
      'price': 78000.00,
    },
    {
      'name': 'Siamese',
      'type': 'Cat',
      'image': 'assets/images/siasemese.jpg',
      'price': 65000.00,
    },
    {
      'name': 'Comet Goldfish',
      'type': 'Fish',
      'image': 'assets/images/comet_goldfish.jpg',
      'price': 1950.00,
    },
    {
      'name': 'Fantail Goldfish',
      'type': 'Fish',
      'image': 'assets/images/fantail_goldfish.jpg',
      'price': 2600.00,
    },
    {
      'name': 'African Grey',
      'type': 'Parrot',
      'image': 'assets/images/african_grey.jpg',
      'price': 156000.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Pet'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: petData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    petData[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petData[index]['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        petData[index]['type'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'KSh ${petData[index]['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/orders');
        },
        backgroundColor: Colors.blue,
        tooltip: 'Next',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
