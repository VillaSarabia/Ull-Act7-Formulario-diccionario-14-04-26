import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleadosScreen extends StatefulWidget {
  const CapturaEmpleadosScreen({super.key});

  @override
  State<CapturaEmpleadosScreen> createState() => _CapturaEmpleadosScreenState();
}

class _CapturaEmpleadosScreenState extends State<CapturaEmpleadosScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text;
      final puesto = _puestoController.text;
      final salario = double.tryParse(_salarioController.text) ?? 0.0;

      // Llamar al agente "guardardatosdiccionario.dart"
      guardarEmpleadoEnDiccionario(nombre, puesto, salario);

      // Mostrar un mensaje de confirmación elegante
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Empleado registrado con éxito.'),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Limpiar formulario
      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
      
      // Regresar foco al primer campo si es necesario, o simplemente limpiar
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Empleado'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Por favor llena los datos del empleado',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Empleado',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _puestoController,
                    decoration: InputDecoration(
                      labelText: 'Puesto',
                      prefixIcon: const Icon(Icons.work_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El puesto es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _salarioController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Salario \$',
                      prefixIcon: const Icon(Icons.monetization_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El salario es obligatorio';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Ingrese un número válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _guardar,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Guardar Datos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
