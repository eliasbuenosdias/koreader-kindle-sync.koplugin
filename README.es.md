KOReader Kindle My Clippings - Plugin de Sincronización
📖 Descripción
Este plugin exporta subrayados y notas de KOReader al formato oficial de Kindle My Clippings.txt, permitiendo que Amazon los sincronice automáticamente con tu cuenta y Goodreads.

Importante: Solo los libros con un ISBN válido serán reconocidos y sincronizados por Amazon con Goodreads. Los libros sin ISBN tendrán sus subrayados exportados localmente, pero no se sincronizarán con Amazon.

✨ Características
✅ Exportación de subrayados al formato My Clippings.txt de Kindle

✅ Detección automática de duplicados (no exportará el mismo subrayado dos veces)

✅ Opción de auto-sincronización: exportar al cerrar el libro

✅ Detección de ISBN: advierte si el libro no se sincronizará con Amazon

✅ Funciona en Kindle (con jailbreak), Kobo, Android y otros dispositivos

✅ Sin dependencias externas

📥 Instalación
1. Descargar el Plugin
Descarga todos los archivos de este repositorio y colócalos en una carpeta llamada koreader-kindle-sync.koplugin

2. Instalar en el Dispositivo
Copia la carpeta koreader-kindle-sync.koplugin en:

Kindle (con jailbreak): /mnt/us/koreader/plugins/

Kobo: /mnt/onboard/.adds/koreader/plugins/

Android: /sdcard/koreader/plugins/

Otros dispositivos: Consulta la documentación de KOReader para la ruta de plugins

3. Reiniciar KOReader
Cierra y vuelve a abrir KOReader para cargar el plugin.

🚀 Uso
Exportación Manual
Abre un libro en KOReader

Pulsa Menú (⚙️) > Herramientas > Kindle My Clippings Sync > Exportar a My Clippings.txt

Revisa el diálogo de confirmación:

✅ ISBN detectado = Se sincronizará con Amazon/Goodreads

⚠️ Sin ISBN = Solo exportación local (no se sincronizará con Amazon)

Pulsa Exportar

Amazon sincronizará los subrayados en pocos minutos (para libros con ISBN)

Auto-sincronización al Cerrar el Libro
Ve a Menú > Herramientas > Kindle My Clippings Sync

Activa "Auto-sincronizar al cerrar libro"

Los subrayados se exportarán automáticamente cada vez que cierres un libro

📂 Ubicación de Salida
Los subrayados se guardan en:

Kindle: /mnt/us/documents/My Clippings.txt

Kobo: /mnt/onboard/My Clippings.txt

Android: /sdcard/My Clippings.txt

⚠️ Notas Importantes
Libros que SE Sincronizarán con Amazon/Goodreads
✅ Libros con ISBN válido en los metadatos

✅ Libros comprados en Amazon (si usas KOReader con libros nativos de Kindle)

✅ Libros cargados manualmente con metadatos ISBN apropiados

Libros que NO SE Sincronizarán con Amazon
❌ Libros sin ISBN

❌ Libros autopublicados que no están en el catálogo de Amazon

❌ PDFs escaneados sin metadatos

❌ Libros con ISBN incorrecto/inválido

Solución: El plugin te avisará si un libro no se sincronizará. Los subrayados se guardarán igualmente de forma local en My Clippings.txt para tus registros.

🛠️ Solución de Problemas
"Error: No se puede escribir en My Clippings.txt"
Kindle: Asegúrate de que el dispositivo no está en modo USB

Android: Verifica los permisos de almacenamiento

Todos los dispositivos: Verifica que KOReader tenga acceso de escritura a la carpeta de documentos

"No se encontraron subrayados"
Asegúrate de haber subrayado texto realmente en el libro

Comprueba que los subrayados son visibles en el menú de marcadores de KOReader

Los Subrayados No Aparecen en Goodreads
Verifica el ISBN: Solo los libros con ISBN se sincronizan con Amazon

Espera: La sincronización de Amazon puede tardar de 5 a 30 minutos

Comprueba Amazon: Visita https://read.amazon.com para ver si los subrayados aparecen allí primero

Conexión con Goodreads: Asegúrate de que tus cuentas de Amazon y Goodreads están vinculadas

🤝 Contribuciones
¡Se aceptan pull requests e informes de errores! Por favor, abre un issue en GitHub.

📄 Licencia
Licencia MIT - consulta el archivo LICENSE para más detalles

⭐ Créditos
Creado por la comunidad KOReader
Guía de desarrollo de plugins: https://github.com/koreader/koreader/wiki/Plugin-development





