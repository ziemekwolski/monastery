namespace :seed do

  desc "Create admin user"
  task admin: :environment do
    unless User.exists?
      User.create!({
        name: "Admin User",
        email: "admin@email.com",
        password: "password"
      })
    end
  end

  desc "Create initial settings"
  task settings: :environment do
    InitSetting.load
  end

end