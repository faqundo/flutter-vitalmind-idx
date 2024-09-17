// lib/screens/advisor_screen.dart
import 'package:flutter/material.dart';

class AdvisorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consejos personalizados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Aquí encontrarás recomendaciones y asesoramiento para ayudarte a alcanzar tus objetivos.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            // Añadir contenido adicional como lista de consejos, imágenes, etc.
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.fitness_center),
                      title: Text('Consejo 1'),
                      subtitle:
                          Text('Haz ejercicio al menos 30 minutos al día.'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.fastfood),
                      title: Text('Consejo 2'),
                      subtitle: Text(
                          'Consume una dieta balanceada y rica en proteínas.'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.water),
                      title: Text('Consejo 3'),
                      subtitle:
                          Text('Bebe al menos 2 litros de agua diariamente.'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
