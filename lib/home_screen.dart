import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TO-DO : Add multiply(*), division(/) and modulus(%) => added

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _fieldOneTEController = TextEditingController();
  final TextEditingController _fieldTwoTEController = TextEditingController();

  void clearText() {
    _fieldOneTEController.clear();
    _fieldTwoTEController.clear();
    result = 0; // Optionally reset the result to 0 when clearing.
    setState(() {}); // Update the UI to reflect the cleared fields.
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sum Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Result is : $result',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            TextFormField(
              controller: _fieldOneTEController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Field 1'),
              validator: (String? value) {
                if (value == null) {
                  return 'Enter a value';
                }
                if (value.trim().isEmpty) {
                  return 'Enter a number';
                }
                // if (value?.trim().isEmpty ?? true) {
                //   return 'Enter valid value';
                // }
                return null;
              },
            ),
            TextFormField(
              controller: _fieldTwoTEController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Field 2'),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter valid value';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: clearText,
              child: const Text('Clear'),
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double firstNumber =
                          parseToDouble(_fieldOneTEController.text.trim());
                      double secondNumber =
                          parseToDouble(_fieldTwoTEController.text.trim());
                      result = addition(firstNumber, secondNumber);
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double firstNumber =
                          parseToDouble(_fieldOneTEController.text.trim());
                      double secondNumber =
                          parseToDouble(_fieldTwoTEController.text.trim());
                      result = sub(firstNumber, secondNumber);
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Sub'),
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double firstNumber =
                          parseToDouble(_fieldOneTEController.text.trim());
                      double secondNumber =
                          parseToDouble(_fieldTwoTEController.text.trim());
                      result = mul(firstNumber, secondNumber);
                      setState(() {});
                    }
                  },
                  icon: const Icon(CupertinoIcons.multiply),
                  label: const Text('mul'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double firstNumber =
                          parseToDouble(_fieldOneTEController.text.trim());
                      double secondNumber =
                          parseToDouble(_fieldTwoTEController.text.trim());
                      result = div(firstNumber, secondNumber);
                      setState(() {});
                    }
                  },
                  icon: const Icon(CupertinoIcons.divide),
                  label: const Text('div'),
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double firstNumber =
                          parseToDouble(_fieldOneTEController.text.trim());
                      double secondNumber =
                          parseToDouble(_fieldTwoTEController.text.trim());
                      result = mod(firstNumber, secondNumber);
                      setState(() {});
                    }
                  },
                  icon: const Icon(CupertinoIcons.percent),
                  label: const Text('mod'),
                ),
              ],
            ),

          ]),
        ),
      ),
    );
  }
}

double parseToDouble(String text) {
  return double.tryParse(text) ?? 0;
}

double addition(
  double firstNum,
  double secondNum,
) {
  return firstNum + secondNum;
}

double sub(
  double firstNum,
  double secondNum,
) {
  return firstNum - secondNum;
}

double mul(
  double firstNum,
  double secondNum,
) {
  return firstNum * secondNum;
}

double div(
  double firstNum,
  double secondNum,
) {
  return firstNum / secondNum;
}

double mod(
  double firstNum,
  double secondNum,
) {
  return firstNum % secondNum;
}
