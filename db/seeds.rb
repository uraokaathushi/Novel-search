# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Genre.create([
#     { genre_name: 'コメディ' },
#     { genre_name: '恋愛' },
#     { genre_name: '青春'},
#     { genre_name: 'ヒューマンドラマ'},
#     { genre_name: '日常'},
#     { genre_name: 'アクション'}
#     ])

 Admin.create!(
   email: 'admin@login',
   password: 'novels',
 )
 
  Admin.create!(
   email: 'admin@login2',
   password: 'aaaaaa',
 )