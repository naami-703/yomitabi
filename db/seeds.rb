# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

山田太郎 = User.find_or_create_by!(email: "test@test.co.jp") do |user|
  user.name = "山田太郎"
  user.password = "password"
  user.introduction = "こんにちは"
  user.favorite_books = "ワンピース"
end

佐藤花子 = User.find_or_create_by!(email: "test2@test.co.jp") do |user|
  user.name = "佐藤花子"
  user.password = "password"
  user.introduction = "よろしく"
  user.favorite_books = "十二国記"
end

Book.find_or_create_by!(title: "四畳半神話大系") do |book|
  book.user_id = 山田太郎.id
end

Book.find_or_create_by!(title: "坂道のアポロン") do |book|
  book.user_id = 佐藤花子.id
end

Spot.find_or_create_by!(name: "鴨川デルタ") do |spot|
  spot.user_id = 山田太郎.id
  spot.address = "京都府京都市左京区下鴨宮河町"
end

Spot.find_or_create_by!(name: "三浦町カトリック教会") do |spot|
  spot.user_id = 佐藤花子.id
  spot.address = "長崎県佐世保市三浦町４−２５"
end