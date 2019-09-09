# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

Priority.create([
	{ name: "Baixa" },
	{ name: "Média" },
	{ name: "Alta" },
	{ name: "Urgente" }
])

Status.create([
	{ name: "Para fazer" },
	{ name: "Em andamento" },
	{ name: "Finalizado" }
])

Member.create([
	{ name: "Daniel Herrman", imgUrl: "https://image.flaticon.com/icons/svg/145/145867.svg" },
	{ name: "Robert Sanders", imgUrl: "https://image.flaticon.com/icons/svg/145/145859.svg" },
	{ name: "Gloria Hurley", imgUrl: "https://image.flaticon.com/icons/svg/145/145852.svg" }
])
