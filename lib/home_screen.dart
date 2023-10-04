import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountOfGlassTEController =
      TextEditingController(text: '1');
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
        totalAmount ++;
        final waterTrack = WaterTrack(DateTime.now(), amount);
        waterConsumeList.add(waterTrack);
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

  void deleteWaterTrack(int index) {
    if (index >= 0 && index < waterConsumeList.length) {
      final deletedAmount = waterConsumeList[index].noOfGlass;
      totalAmount -= deletedAmount;
      waterConsumeList.removeAt(index);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Total consume',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '$totalAmount',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
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
                final waterTrack = waterConsumeList[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    onLongPress: () {
                      deleteWaterTrack(index);
                    },
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(DateFormat('HH:mm:ss a')
                        .format(waterTrack.time)),
                    subtitle: Text(DateFormat('dd-MM-yyyy')
                        .format(waterTrack.time)),
                    trailing: Text(
                      'Number of Glass Water: ${waterTrack.noOfGlass}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
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
