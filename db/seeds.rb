# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([
                  { slug: 'electronics' },
                  { slug: 'fashion' },
                  { slug: 'home' }
                ])

Category.find_by(slug: 'electronics').subcategories.create([
                                                              { slug: 'smartphones' },
                                                              { slug: 'laptops' }
                                                            ])


Product.create([
                 {
                   title: 'Smartphone',
                   description: 'A smartphone is a mobile device that combines cellular and mobile computing functions into one unit.',
                   variants: [
                     { color: 'black', size: '6.1 inch' },
                     { color: 'white', size: '6.1 inch' }
                   ],
                   category_id: Category.find_by(slug: 'smartphones').id,
                   price: 1000
                 },
                 {
                   title: 'Laptop',
                   description: 'A laptop is a small, portable personal computer (PC) with a clamshell form factor, typically having a thin LCD or LED computer screen mounted on the inside of the upper lid of the clamshell and an alphanumeric keyboard on the inside of the lower lid.',
                   variants: [
                     { color: 'black', size: '15 inch' },
                     { color: 'white', size: '15 inch' }
                   ],
                   category_id: Category.find_by(slug: 'smartphones').id,
                   price: 2000
                 },
                 {
                   title: 'T-shirt',
                   description: 'A T-shirt is a style of fabric shirt named after the T shape of its body and sleeves.',
                   variants: [
                     { color: 'red', size: 's' },
                     { color: 'green', size: 'm' }
                   ],
                   category_id: Category.find_by(slug: 'fashion').id,
                   price: 20
                 },
                 {
                   title: 'Jeans',
                   description: 'Jeans are a type of pants or trousers, typically made from denim or dungaree cloth.',
                   variants: [
                     { color: 'blue', size: 's' }
                   ],
                   category_id: Category.find_by(slug: 'fashion').id,
                   price: 50
                 },
                 {
                   title: 'Sofa',
                   description: 'A sofa is a piece of furniture that a few people can sit on.',
                   variants: [
                     { color: 'brown', size: '3-seater' },
                     { color: 'white', size: '2-seater' }
                   ],
                   category_id: Category.find_by(slug: 'home').id,
                   price: 500
                 },
                 {
                   title: 'Dining Table',
                   description: 'A dining table is a table where people can sit and eat meals.',
                   variants: [
                     { color: 'brown', size: '6-seater' },
                     { color: 'white', size: '4-seater' }
                   ],
                   category_id: Category.find_by(slug: 'home').id,
                   price: 300
                 }
               ])
