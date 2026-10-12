import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sasso Carta Forbice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Sasso Carta Forbice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Possibili scelte
  final List<String> _scelte = ['Sasso', 'Carta', 'Forbice'];

  // Stato del gioco
  String _sceltaGiocatore = '';
  String _sceltaPc = '';
  String _risultato = 'Fai la tua scelta!';

  // Punteggi opzionali ma utili per divertirsi di più
  int _puntiGiocatore = 0;
  int _puntiPc = 0;

  // Funzione che gestisce la mossa
  void _gioca(String sceltaGiocatore) {
    // 1. Genera la scelta casuale del PC (indice 0, 1 o 2)
    final random = Random();
    final indicePc = random.nextInt(3);
    final sceltaPc = _scelte[indicePc];

    // 2. Determina il vincitore
    String risultato = '';
    if (sceltaGiocatore == sceltaPc) {
      risultato = 'Pareggio!';
    } else if (
      (sceltaGiocatore == 'Sasso' && sceltaPc == 'Forbice') ||
      (sceltaGiocatore == 'Forbice' && sceltaPc == 'Carta') ||
      (sceltaGiocatore == 'Carta' && sceltaPc == 'Sasso')
    ) {
      risultato = 'Hai vinto! 🎉';
      _puntiGiocatore++;
    } else {
      risultato = 'Ha vinto il PC! 💻';
      _puntiPc++;
    }

    // 3. Aggiorna lo stato con setState
    setState(() {
      _sceltaGiocatore = sceltaGiocatore;
      _sceltaPc = sceltaPc;
      _risultato = risultato;
    });
  }

  // Funzione per azzerare i punteggi
  void _resetPartita() {
    setState(() {
      _sceltaGiocatore = '';
      _sceltaPc = '';
      _risultato = 'Fai la tua scelta!';
      _puntiGiocatore = 0;
      _puntiPc = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Punteggio
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Tu: $_puntiGiocatore', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('PC: $_puntiPc', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),

              // Risultato del round
              Text(
                _risultato,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Scelte effettuate
              if (_sceltaGiocatore.isNotEmpty) ...[
                Text('La tua scelta: $_sceltaGiocatore', style: const TextStyle(fontSize: 16)),
                Text('La scelta del PC: $_sceltaPc', style: const TextStyle(fontSize: 16)),
              ],
              const SizedBox(height: 40),

              const Text('Scegli la tua mossa:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 15),

              // Pulsanti per scegliere Sasso, Carta o Forbice
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _gioca('Sasso'),
                    child: const Text('🪨 Sasso'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _gioca('Carta'),
                    child: const Text('📄 Carta'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _gioca('Forbice'),
                    child: const Text('✂️ Forbice'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Pulsante per resettare
              TextButton(
                onPressed: _resetPartita,
                child: const Text('Ricomincia da capo', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}