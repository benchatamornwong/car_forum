namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)

    Board.create!(title: "General")
    Board.create!(title: "Pic Post")
    Board.create!(title: "Market")

    password  = "password"

    User.create!(name: "Keepok",
                  email: "keepok@keepok.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Ou PotFace",
                  email: "outhemaster@gmail.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Opal RubyKing",
                  email: "opal@gmail.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Sun RoundFace",
                  email: "sun@gmail.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Tee 2D",
                  email: "tee@gmail.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Tii Winit",
                  email: "tii@gmail.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Kelly TheWhale",
                  email: "kelly@ocean.com",
                  password: password,
                  password_confirmation: password)
    
    User.create!(name: "Jing CSSMaster",
                  email: "jing@gmail.com",
                  password: password,
                  password_confirmation: password)

    User.create!(name: "Mint TheMammoth",
                  email: "mint@gmail.com",
                  password: password,
                  password_confirmation: password)
  end
end