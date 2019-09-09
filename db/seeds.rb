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
	{ name: "To Do" },
	{ name: "Doing" },
	{ name: "Done" }
])

Member.create([
	{ name: "Daniel Herrman", imgUrl: "https://pt.fakenamegenerator.com/images/sil-male.png" },
	{ name: "Robert Sanders", imgUrl: "https://pt.fakenamegenerator.com/images/sil-male.png" },
	{ name: "Gloria Hurley", imgUrl: "https://pt.fakenamegenerator.com/images/sil-female.png" }
])
