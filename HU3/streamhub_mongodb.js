// =====================================
// STREAMHUB - MongoDB Script
// =====================================

// TASK 1 - Base de datos

// =====================================
// TASK 2 - Inserciones
// =====================================

db.usuarios.insertMany([
{
  nombre: "Juan Pérez",
  email: "juan@mail.com",
  edad: 25,
  pais: "Colombia",
  fecha_registro: new Date("2025-01-10"),
  historial_vistos: []
},
{
  nombre: "Laura Gómez",
  email: "laura@mail.com",
  edad: 30,
  pais: "México",
  fecha_registro: new Date("2025-02-15"),
  historial_vistos: []
},
{
  nombre: "Carlos Ruiz",
  email: "carlos@mail.com",
  edad: 22,
  pais: "Colombia",
  fecha_registro: new Date("2025-03-01"),
  historial_vistos: []
}
])

db.contenidos.insertMany([
{
  titulo: "Interestelar",
  tipo: "pelicula",
  genero: ["Ciencia Ficción", "Drama"],
  duracion_minutos: 169,
  anio_lanzamiento: 2014
},
{
  titulo: "El Padrino",
  tipo: "pelicula",
  genero: ["Crimen", "Drama"],
  duracion_minutos: 175,
  anio_lanzamiento: 1972
},
{
  titulo: "Stranger Things",
  tipo: "serie",
  genero: ["Ciencia Ficción", "Terror"],
  duracion_minutos: 50,
  temporadas: 4,
  anio_lanzamiento: 2016
},
{
  titulo: "Breaking Bad",
  tipo: "serie",
  genero: ["Drama", "Crimen"],
  duracion_minutos: 47,
  temporadas: 5,
  anio_lanzamiento: 2008
}
])

// =====================================
// TASK 3 - Consultas
// =====================================

db.contenidos.find({ duracion_minutos: { $gt: 120 } })
db.contenidos.find({ duracion_minutos: { $lt: 60 } })
db.contenidos.find({ tipo: { $eq: "serie" } })
db.contenidos.find({ genero: { $in: ["Drama"] } })

db.contenidos.find({
  $and: [
    { tipo: "pelicula" },
    { duracion_minutos: { $gt: 150 } }
  ]
})

db.usuarios.find({
  $or: [
    { pais: "Colombia" },
    { edad: { $lt: 25 } }
  ]
})

db.contenidos.find({
  titulo: { $regex: "Inter", $options: "i" }
})

// =====================================
// TASK 4 - Updates y Deletes
// =====================================

db.contenidos.updateOne(
  { titulo: "Interestelar" },
  { $set: { duracion_minutos: 170 } }
)

db.contenidos.updateMany(
  { tipo: "pelicula" },
  { $set: { disponible: true } }
)

db.valoraciones.deleteOne({ puntuacion: 1 })

db.contenidos.deleteMany({
  anio_lanzamiento: { $lt: 2000 }
})

// =====================================
// TASK 5 - Índices
// =====================================

db.contenidos.createIndex({ titulo: 1 })
db.contenidos.createIndex({ genero: 1 })
db.contenidos.getIndexes()

// =====================================
// AGREGACIONES
// =====================================

db.contenidos.aggregate([
  {
    $group: {
      _id: "$tipo",
      total: { $sum: 1 }
    }
  },
  { $sort: { total: -1 } }
])

db.contenidos.aggregate([
  { $unwind: "$genero" },
  {
    $group: {
      _id: "$genero",
      total: { $sum: 1 }
    }
  },
  { $sort: { total: -1 } }
])