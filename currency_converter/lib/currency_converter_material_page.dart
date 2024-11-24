import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatelessWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 3.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.circular(60.0),
      gapPadding: 10.0,
    );

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '0',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  // color: Color.fromRGBO(255, 0, 0, 1.0),
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    // labelText: 'Enter amount',
                    // labelStyle: TextStyle(
                    //   color: Colors.black,
                    // ),
                    // helperText: 'Enter amount',
                    hintText: "Please enter the amount in USD",
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    prefixIcon: const Icon(Icons.monetization_on),
                    prefixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: const BorderSide(
                    //     color: Colors.black,
                    //     width: 3.0,
                    //     style: BorderStyle.solid,
                    //     strokeAlign: BorderSide.strokeAlignOutside,
                    //   ),
                    //   borderRadius: BorderRadius.circular(60.0),
                    //   gapPadding: 10.0,
                    // ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: const BorderSide(
                    //     color: Colors.black,
                    //     width: 3.0,
                    //     style: BorderStyle.solid,
                    //     strokeAlign: BorderSide.strokeAlignOutside,
                    //   ),
                    //   borderRadius: BorderRadius.circular(60.0),
                    //   gapPadding: 10.0,
                    // ),
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              TextButton(
                onPressed: () {
                  print('Convert button pressed');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey),
                  padding: WidgetStateProperty.all(const EdgeInsets.all(10.0)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
