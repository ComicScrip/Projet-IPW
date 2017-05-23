# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#load local ENV
env_file = File.join(Rails.root, 'config', 'local_env.yml')
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key.to_s] = value
end if File.exists?(env_file)

#defaults roles
['admin', 'teacher', 'student'].each do |role_name|
  Role.create! name: role_name
end

# admin user
admin = User.create! firstName: 'Admin', lastName: 'Admin', approved: true, email: ENV['ASSESSME_ADMIN_EMAIL'], password: ENV['ASSESSME_ADMIN_PASSWORD']
admin.add_role 'admin'
