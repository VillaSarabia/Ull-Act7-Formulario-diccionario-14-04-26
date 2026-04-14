import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.deepPurple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.business_center,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Gestión de Empleados',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/capturar');
                  },
                  icon: const Icon(Icons.person_add, size: 24),
                  label: const Text('Capturar Empleados', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ver');
                  },
                  icon: const Icon(Icons.group, size: 24),
                  label: const Text('Ver Empleados', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
