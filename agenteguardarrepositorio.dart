import 'dart:io';

void main() async {
  print('\n======================================================');
  print('🤖 Agente: Guardar Repositorio en GitHub 🤖');
  print('======================================================\n');

  // 1. Verificar si git está instalado
  var gitCheck = await Process.run('git', ['--version']);
  if (gitCheck.exitCode != 0) {
    print('❌ Error: Git no parece estar instalado o no está en tu PATH.');
    print('Por favor instala Git antes de usar este agente.');
    return;
  }
  print('✅ Git detectado: ${gitCheck.stdout.trim()}');

  // 2. Comprobar si ya es un repositorio, si no, inicializarlo
  var statusCheck = await Process.run('git', ['status']);
  if (statusCheck.exitCode != 0) {
    print('➡️  Inicializando nuevo repositorio de Git...');
    await Process.run('git', ['init']);
  } else {
    print('➡️  Este directorio ya cuenta con un repositorio de Git local.');
  }

  // 3. Revisar si hay un control remoto, y pedir enlace
  var remoteCheck = await Process.run('git', ['remote', 'get-url', 'origin']);
  String currentRemote = remoteCheck.exitCode == 0 ? remoteCheck.stdout.trim() : '';

  if (currentRemote.isNotEmpty) {
    print('➡️  Actual origin configurado: $currentRemote');
  }

  stdout.write('\n🔗 Introduce el enlace del repositorio de GitHub (ej. https://github.com/usuario/repo.git)\n[Presiona Enter si no deseas cambiar/agregar el enlace]: ');
  String? repoLink = stdin.readLineSync()?.trim();

  if (repoLink != null && repoLink.isNotEmpty) {
    if (currentRemote.isNotEmpty) { // Si ya había enlace, lo actualizamos
      await Process.run('git', ['remote', 'set-url', 'origin', repoLink]);
      print('✅ URL de origin actualizada a $repoLink');
    } else { // Si no, lo creamos
      await Process.run('git', ['remote', 'add', 'origin', repoLink]);
      print('✅ URL de origin agregada: $repoLink');
    }
  } else if (currentRemote.isEmpty) {
    print('⚠️  Aviso: No se proporcionó un enlace remoto. No se podrá ejecutar "git push" hasta que agregues un destino.');
  }

  // 4. Establecer rama por defecto
  stdout.write('\n🌿 ¿A qué rama deseas subir los cambios? [Por defecto: main]: ');
  String? rama = stdin.readLineSync()?.trim();
  if (rama == null || rama.isEmpty) {
    rama = 'main';
  }
  await Process.run('git', ['branch', '-M', rama]);
  print('✅ Rama actual ajustada a: $rama');

  // 5. Preguntar el mensaje del commit
  stdout.write('\n📝 Introduce el mensaje del commit [Por defecto: "Actualización de código"]: ');
  String? commitMsg = stdin.readLineSync()?.trim();
  if (commitMsg == null || commitMsg.isEmpty) {
    commitMsg = 'Actualización de código';
  }

  // 6. Preparar y crear el commit
  print('\n📦 Añadiendo archivos (git add .)...');
  await Process.run('git', ['add', '.']);

  print('💾 Creando commit...');
  var commitResult = await Process.run('git', ['commit', '-m', commitMsg]);
  if (commitResult.exitCode != 0) {
    String output = commitResult.stdout.toString();
    if (output.contains('nothing to commit') || output.contains('nada para hacer commit')) {
      print('⚠️  No se ha detectado ningún cambio nuevo para hacer commit.');
    } else {
      print('❌ Ocurrió un error al hacer commit: $output');
    }
  } else {
    print('✅ Commit exitoso: "$commitMsg"');
  }

  // Si no hay remote configurado, detenemos la ejecución antes de hacer push
  var finalRemoteCheck = await Process.run('git', ['remote', 'get-url', 'origin']);
  if (finalRemoteCheck.exitCode != 0) {
    print('\n🎉 Proceso local terminado. Faltó especificar la URL remota para subir a GitHub.');
    return;
  }

  // 7. Push a GitHub
  print('\n🚀 Subiendo el proyecto a la rama "$rama" en GitHub...');
  
  // Utilizar Process.start nos permite ver la consola en tiempo real
  var pushProcess = await Process.start('git', ['push', '-u', 'origin', rama]);
  
  // Redirigir la salida del proceso iterativo a la consola de Dart interactivo
  stdout.addStream(pushProcess.stdout);
  stderr.addStream(pushProcess.stderr);

  var exitCode = await pushProcess.exitCode;
  
  if (exitCode == 0) {
    print('\n======================================================');
    print('🌟 ¡ÉXITO! El repositorio se ha subido correctamente. 🌟');
    print('======================================================\n');
  } else {
    print('\n======================================================');
    print('❌ Hubo un problema al subir el proyecto. Verifica tu conexión,');
    print('los permisos de tu cuenta, o si hace falta configurar un Token de GitHub.');
    print('======================================================\n');
  }
}
