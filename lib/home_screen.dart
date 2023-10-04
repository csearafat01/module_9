import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountOfGlassTEController = TextEditingController();
  List<WaterTrack> waterConsumeList = [];
  int totalAmount = 0;

  @override
  void dispose() {
    _amountOfGlassTEController.dispose();
    super.dispose();
  }

  void addWaterTrack() {
    final input = _amountOfGlassTEController.text.trim();
    if (input.isNotEmpty) {
      final amount = int.tryParse(input);
      if (amount != null) {
        final waterTrack = WaterTrack(DateTime.now(), amount);
        waterConsumeList.add(waterTrack);
        totalAmount += amount; // Add to the total count
        _amountOfGlassTEController.clear();
        setState(() {});
      } else {
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid input. Please enter a valid number.'),
          ),
        );
      }
    }
  }

  // Function to delete a water consumption entry and subtract its amount from the total
  void deleteWaterTrack(int index) {
    if (index >= 0 && index < waterConsumeList.length) {
      final deletedAmount = waterConsumeList[index].noOfGlass;
      waterConsumeList.removeAt(index);
      totalAmount -= deletedAmount; // Subtract from the total count
      setState(() {});
    }
  }

  // Function to calculate the total consume for each date
  Map<String, int> calculateTotalConsume(List<WaterTrack> tracks) {
    final totalConsumeMap = <String, int>{};
    for (final track in tracks) {
      final dateKey = DateFormat('yyyy-MM-dd').format(track.time);
      totalConsumeMap[dateKey] = (totalConsumeMap[dateKey] ?? 0) + track.noOfGlass;
    }
    return totalConsumeMap;
  }

  @override
  Widget build(BuildContext context) {
    final totalConsumeMap = calculateTotalConsume(waterConsumeList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _amountOfGlassTEController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: addWaterTrack,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: waterConsumeList.length,
              itemBuilder: (context, index) {
                final dateKey = DateFormat('yyyy-MM-dd').format(waterConsumeList[index].time);

                return DateSection(
                  dateKey: dateKey,
                  waterTrack: waterConsumeList[index],
                  totalConsume: totalConsumeMap[dateKey] ?? 0,
                  onDelete: () {
                    deleteWaterTrack(index);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class WaterTrack {
  final DateTime time;
  final int noOfGlass;

  WaterTrack(this.time, this.noOfGlass);
}

class DateSection extends StatelessWidget {
  final String dateKey;
  final WaterTrack waterTrack;
  final int totalConsume;
  final VoidCallback onDelete;

  const DateSection({super.key, 
    required this.dateKey,
    required this.waterTrack,
    required this.totalConsume,
    required this.onDelete,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dateKey,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.countertops),
            ),
            title: Text(
              DateFormat('HH:mm:ss a').format(waterTrack.time),

            ),
            subtitle: Text(
    'Total Consume: $totalConsume',
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),

            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ),
        ),
      ],
    );
  }
}
