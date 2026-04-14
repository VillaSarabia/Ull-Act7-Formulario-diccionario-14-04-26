import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleadosScreen extends StatelessWidget {
  const VerEmpleadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos la lista de empleados convirtiendo los values del diccionario
    final listaEmpleados = datosempleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: listaEmpleados.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 20),
                  Text(
                    'Aún no hay empleados registrados.',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: listaEmpleados.length,
              itemBuilder: (context, index) {
                final empleado = listaEmpleados[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      radius: 25,
                      child: Text(
                        empleado.id.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    title: Text(
                      empleado.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text('Puesto: ${empleado.puesto}', style: const TextStyle(fontSize: 15)),
                        const SizedBox(height: 3),
                        Text(
                          'Salario: \$${empleado.salario.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
