import 'claseempleado.dart';
import 'diccionarioempleado.dart';

void guardarEmpleadoEnDiccionario(String nombre, String puesto, double salario) {
  // Crear un nuevo empleado usando la clase
  Empleado nuevoEmpleado = Empleado(
    id: autoId,
    nombre: nombre,
    puesto: puesto,
    salario: salario,
  );
  
  // Guardarlo en el diccionario
  datosempleado[autoId] = nuevoEmpleado;
  
  // Incrementar el id autonumérico para el próximo empleado
  autoId++;
}
