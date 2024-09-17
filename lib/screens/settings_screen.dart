import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Aquí puedes volver a la pantalla anterior
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Ajustes',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primera Sección: Gestionar mis notificaciones y Aplicaciones de salud
            SettingsOption(
              title: "Gestionar mis notificaciones",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SettingsOption(
              title: "Aplicaciones de salud",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SizedBox(height: 20),
            // Título "Otros"
            Text(
              'Otros',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Segunda Sección: Otras opciones
            SettingsOption(
              title: "Contáctenos",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SettingsOption(
              title: "Agregar amigos",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SettingsOption(
              title: "Púntuenos",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SettingsOption(
              title: "Cerrar sesión",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SettingsOption(
              title: "Términos de uso",
              onTap: () {
                // Acción al pulsar
              },
            ),
            SettingsOption(
              title: "Política de privacidad",
              onTap: () {
                // Acción al pulsar
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reutilizable para cada opción
class SettingsOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  SettingsOption({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
