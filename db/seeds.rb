# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

山田太郎 = User.find_or_create_by!(email: "test@test.co.jp") do |user|
  user.name = "山田太郎"
  user.password = "111111"
  user.introduction = "こんにちは"
  user.favorite_books = "ミステリー小説全般"
end

佐藤花子 = User.find_or_create_by!(email: "test2@test.co.jp") do |user|
  user.name = "小林花子"
  user.password = "222222"
  user.introduction = "よろしくお願いします！"
  user.favorite_books = "ベルサイユのばら"
end

Admin.find_or_create_by!(email: "admin@admin.co.jp") do |admin|
  admin.password = "000000"
end