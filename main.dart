import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());    //jo kam hai project mn wo name aiega, idhr class name calculator hai jhn neche mainclass mn wohi name use hoga
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        //using light color for app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),  //using light color
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});


  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}


  class _CalculatorScreenState extends State<CalculatorScreen> {
  // using controllers for textfields to get user inputt
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _result = '';  //shows result

  //making methods to perform calculation of operations

  void _calculate(String operation)
  {
    //values we get from input parse them as double
    double? num1 = double.tryParse(_controller1.text);   //_controller1.text -> retrieving input as string, so " double.tryParse(String input) " -> convert string into double
    double? num2 = double.tryParse(_controller2.text);  //doubel? -> means can handle cases where parsing fails so it show null then..

   if(num1==null || num2==null)
     {
       //agr parsing fails it shows error msg
    setState(() {
      _result='Enter valid numbers';
    });
  return;
     }
    //perform calculation based on slelected opera:
    double calculationResult;
    switch(operation)
        {
      case 'add':
        calculationResult = num1 + num2;
        break;
      case 'subtract':
        calculationResult = num1 - num2;
        break;
      case 'multiply':
        calculationResult = num1 * num2;
        break;
      case 'divide':
        if (num2 == 0) {
          setState(() {
            _result = 'Cannot divide by zero';
          });
          return;
        }
        calculationResult = num1 / num2;
        break;
      default:
        calculationResult = 0;
    }
    //update the result

    setState(() {
      _result ='Result: $calculationResult';
    });
  }
//dispose cleanup the resources as the widgets remove
  @override
  void dispose() {
    // Dispose of the controller to avoids memory leak
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

//for the APP BAR...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar of light color
        backgroundColor: Colors.lightBlueAccent,
        title:const Text('Simple Calculator'),
      ),
      body: Container(
        //applyingg bg color
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(20.0),  //20.0 means equal edges on all 4sides

        child: Column(                                        //column arrange widgets vertically
          mainAxisAlignment: MainAxisAlignment.center,      //controlls alignment of childrens, and center them
          children: <Widget>[
            //first textField
            TextField(
              controller:  _controller1,
            keyboardType: TextInputType.number,                  //specify keyboard should display numeric keys
            decoration: const InputDecoration(      //give appearnce to textfield

              border: OutlineInputBorder(),           //makes boarder around textfield
              labelText: 'Enter first number',
              filled: true,                   //ensure textfiled fill with colors
              fillColor: Colors.white,
            ),
            ),
            const SizedBox(height: 20), // create fixed Space btw widges

            // Second Text Field
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter second number',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Spacing

 //row for operation buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Add Button
            ElevatedButton(
              onPressed: () => _calculate('add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: const Text('Add'),
            ),
            // Subtract Button
            ElevatedButton(
              onPressed: () => _calculate('subtract'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: const Text('Subtract'),
            ),
          ],
        ),
            const SizedBox(height: 10), // Spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Multiply Button
                ElevatedButton(
                  onPressed: () => _calculate('multiply'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  child: const Text('Multiply'),
                ),
                // Divide Button
                ElevatedButton(
                  onPressed: () => _calculate('divide'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  child: const Text('Divide'),
                ),
              ],
            ),
            const SizedBox(height: 20), // Spacing

            // Display the result
            Text(
              _result,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
  }