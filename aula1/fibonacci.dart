import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Sequência de Fibonacci',
    home: FibonacciScreen(),
  ));
}

class FibonacciScreen extends StatefulWidget {  //stateful por mostrar o resutaldo
  @override
  _FibonacciScreenState createState() => _FibonacciScreenState();
}

class _FibonacciScreenState extends State<FibonacciScreen> {
  TextEditingController numberController = TextEditingController();
  int fibonacciNumber = 0; //para começar do zero
  List<int> fibonacciSequence = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // deixando a cor padrao azul
        title: const Text('Sequência de Fibonacci'),
      ),
      body: ListView( //Listview para nao dar erro quebra de espaço
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Digite um número',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    int n = int.parse(numberController.text);
                    setState(() {
                      fibonacciNumber = fibonacci(n);
                      fibonacciSequence = [];
                    });
                  },
                  child: const Text('Mostrar Número'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    int n = int.parse(numberController.text);
                    setState(() {
                      fibonacciNumber = 0;
                      fibonacciSequence = generateFibonacciSequence(n);
                    });
                  },
                  child: const Text('Mostrar Sequência'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fibonacciNumber = 0;
                      fibonacciSequence = [];
                      numberController.clear();
                    });
                  },
                  child: const Text('Limpar'),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Resultado:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(fibonacciNumber != 0 ? fibonacciNumber.toString() : ''),
                const SizedBox(height: 8.0),
                Text(fibonacciSequence.isNotEmpty ? fibonacciSequence.join(', ') : ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int fibonacci(int n) {//aqui começa o exercicio proposto no masterclass que seria uma função para mostrar fibonacci
    if (n <= 0) {
      return 0; // Caso base: retorna 0 quando n é menor ou igual a 0
    } else if (n == 1 || n == 2) {
      return 1; // Caso base: retorna 1 quando n é igual a 1 ou 2
    } else {
      // Caso recursivo: soma os dois números anteriores da sequência
      return fibonacci(n - 1) + fibonacci(n - 2);
    }
  }

  List<int> generateFibonacciSequence(int n) { //aqui retorna a sequencia em varios numeros
    List<int> sequence = [];
    for (int i = 1; i <= n; i++) {
      sequence.add(fibonacci(i));
    }
    return sequence;
  }
}
