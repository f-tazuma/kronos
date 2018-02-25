require_relative "./m_department_seeder"
require_relative "./m_price_rate_seeder"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テーブル:m_departments
MDepartmentSeeder::run()

# テーブル:m_price_rates
MPriceRateSeeder::run()