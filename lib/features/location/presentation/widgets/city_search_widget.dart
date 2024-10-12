import 'package:flutter/material.dart';

class CitySearchWidget extends StatefulWidget {
  final TextEditingController cityController;

  const CitySearchWidget({super.key, required this.cityController});

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: widget.cityController,
                decoration: const InputDecoration(
                  hintText: 'Location',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
                  prefixIcon:
                      Icon(Icons.search, color: Color.fromARGB(255, 0, 33, 60)),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              final cityName = widget.cityController.text.trim();
              if (cityName.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: {
                    'cityName': cityName,
                  },
                );
                widget.cityController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              backgroundColor: Colors.grey.withOpacity(0.7),
              textStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Get Weather',
              style: TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
            ),
          ),
        ],
      ),
    );
  }
}
