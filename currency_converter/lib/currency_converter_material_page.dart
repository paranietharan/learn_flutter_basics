import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  final TextEditingController _controller = TextEditingController();
  double _convertedAmount = 0;

  void _convertCurrency() {
    final inputAmount = double.tryParse(_controller.text);
    if (inputAmount != null) {
      setState(() {
        _convertedAmount = inputAmount * 100; // Conversion rate: 1 USD = 100 INR
      });
    } else {
      setState(() {
        _convertedAmount = 0; // Reset if input is invalid
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 3.0,
      ),
      borderRadius: BorderRadius.circular(60.0),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Converted Amount: ₹${_convertedAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter amount in USD",
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            TextButton(
              onPressed: _convertCurrency,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.grey),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const Text(
                'Convert',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}