class InitRolesAndAdminAccount < ActiveRecord::Migration
  def self.up
    #defaults roles
    ['admin', 'teacher', 'student'].each do |role_name|
      Role.create! name: role_name
    end

    # admin user
    admin = User.create! firstName: 'Admin', lastName: 'Admin', approved: true, email: ENV['ASSESSME_ADMIN_EMAIL'], password: ENV['ASSESSME_ADMIN_PASSWORD']
    admin.add_role 'admin'
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end