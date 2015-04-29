# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

matt = User.create(name: "Matt")

board_1 = Board.create(name: "Software Developer Job Hunt", user_id: User.first.id)
list_1 = List.create(board_id: Board.first.id, name: "Organizations of Interest", position_id: 1)
list_2 = List.create(board_id: Board.first.id, name: "Finding Advocate", position_id: 2)
list_3 = List.create(board_id: Board.first.id, name: "Initial Application", position_id: 3)
list_4 = List.create(board_id: Board.first.id, name: "Cultural Interview", position_id: 4)
list_5 = List.create(board_id: Board.first.id, name: "Tech Screen/Code Challenge", position_id: 5)
list_6 = List.create(board_id: Board.first.id, name: "Onsite", position_id: 6)

card_1 = Card.create(list_id: 1, organization_name: "Google")
card_2 = Card.create(list_id: 1, organization_name: "ZenPayroll")
card_3 = Card.create(list_id: 2, organization_name: "Adobe")
card_4 = Card.create(list_id: 2, organization_name: "Facebook")
card_5 = Card.create(list_id: 2, organization_name: "Wired")
card_6 = Card.create(list_id: 2, organization_name: "Make")
card_7 = Card.create(list_id: 3, organization_name: "Amazon")
