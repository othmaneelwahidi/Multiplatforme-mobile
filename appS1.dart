import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFFBF9F6),
      ),
      home: const IMCHomePage(),
    );
  }
}

class IMCHomePage extends StatefulWidget {
  const IMCHomePage({Key? key}) : super(key: key);

  @override
  State<IMCHomePage> createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  // Contrôleurs pour récupérer le texte des champs de saisie
  final TextEditingController _poidsController = TextEditingController();
  final TextEditingController _tailleController = TextEditingController();

  // Variables d'état pour l'affichage des résultats
  double? _imc;
  String _categorie = "";
  String _imagePath = ""; // Contiendra img1, img2, etc.

  void _calculerIMC() {
    final double? poids = double.tryParse(_poidsController.text);
    final double? tailleCm = double.tryParse(_tailleController.text);

    if (poids == null || tailleCm == null || poids <= 0 || tailleCm <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez saisir des valeurs valides')),
      );
      return;
    }

    // Calcul de l'IMC : Poids (kg) / Taille^2 (m)
    final double tailleMeres = tailleCm / 100;
    final double imcCalcule = poids / (tailleMeres * tailleMeres);

    setState(() {
      _imc = imcCalcule;

      // Détermination de la catégorie et de l'image correspondante
      if (_imc! < 18.5) {
        _categorie = "Maigreur";
        _imagePath = "img1";
      } else if (_imc! >= 18.5 && _imc! < 25) {
        _categorie = "Normal";
        _imagePath = "img2";
      } else if (_imc! >= 25 && _imc! < 30) {
        _categorie = "Surpoids";
        _imagePath = "img3";
      } else if (_imc! >= 30 && _imc! < 40) {
        _categorie = "Obésité modérée";
        _imagePath = "img4";
      } else {
        _categorie = "Obésité sévère";
        _imagePath = "img5";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC For II-Master BDCC 1'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'quel est votre IMC ?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 30),

            // Champ de saisie du Poids
            Row(
              children: [
                const SizedBox(
                  width: 70,
                  child: Text('Poids', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: TextField(
                    controller: _poidsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: '87'),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Kg', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            // Champ de saisie de la Taille
            Row(
              children: [
                const SizedBox(
                  width: 70,
                  child: Text('Taille', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: TextField(
                    controller: _tailleController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: '177'),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Cm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 35),

            // Bouton Calculer
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _calculerIMC,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Calculer IMC',
                  style: TextStyle(fontSize: 16, color: Colors.white)
                ),
              ),
            ),
            const SizedBox(height: 35),

            // Section Affichage des Résultats
            if (_imc != null) ...[
              Text(
                'Votre IMC est: ${_imc!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Zone d'affichage de l'image correspondante (img1, img2, etc.)
              Container(
                width: 100,
                height: 120,
                color: Colors.grey[300], // Fond de secours
                alignment: Alignment.center,
                // Remplacer par Image.asset("assets/$_imagePath.png") une fois vos images ajoutées
                child: Text(
                  _imagePath,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)
                ),
              ),
              const SizedBox(height: 15),

              Text(
                _categorie,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black80),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
