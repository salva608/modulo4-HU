StreamHub - MongoDB. 
Descripción

Este proyecto modela e implementa una base de datos NoSQL en MongoDB para la plataforma StreamHub, incluyendo:

Colecciones de usuarios, contenidos y valoraciones

Operaciones CRUD

Uso de operadores de consulta

Creación de índices

Pipelines de agregación para métricas

El archivo principal contiene todos los comandos ejecutados en MongoDB.

Requisitos

Antes de ejecutar el script, asegúrese de tener instalado:

MongoDB Server

Mongosh (MongoDB Shell)

Verificar instalación:

mongosh --version
Archivo incluido

streamhub_mongodb.js → Contiene todos los comandos:

Inserciones

Consultas

Actualizaciones

Eliminaciones

Índices

Agregaciones

Cómo ejecutar el script

Abrir la terminal (CMD o PowerShell).

Ubicarse en la carpeta donde está el archivo:

cd ruta\de\la\carpeta

Ejecutar el siguiente comando:

mongosh streamhub --file streamhub_mongodb.js

Este comando:

Crea/usa la base de datos streamhub

Ejecuta todas las operaciones definidas en el script

Verificación

Después de ejecutar el script:

mongosh

Luego dentro de mongosh:

use streamhub
show collections

Para verificar datos:

db.usuarios.find()
db.contenidos.find()
Notas

Si la base de datos ya existe, el script insertará nuevamente los datos.

Los índices pueden verificarse con:

db.contenidos.getIndexes()