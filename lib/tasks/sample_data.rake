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

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

      Post.create!(title: "BMW #{n+1} Series",
                    content: "BMW #{n+1} Series",
                    board_id: 1,
                    user_id: 1)
      Comment.create!(content: n,
                    user_id:1,
                    post_id:n+1)
    end
  end
end