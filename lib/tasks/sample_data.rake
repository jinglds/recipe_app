namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_recipes
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_recipes
  users = User.all(limit: 6)
  50.times do
    name = ['food', 'fish', 'banana', 'apple', 'chocolate', 'cake', 'rice', 'steak', 'milkshake']
    level = ['1','2','3','4']
    cook_time = ['10','20','30','40','50','60']
    course = ['appetizer', 'main', 'dessert', 'beverage']
    serving = ['1','2','3']
    description = Faker::Lorem.sentence(5)
    ingredients = Faker::Lorem.words(10).join
    directions = Faker::Lorem.sentence(6)
    privacy = ['public','private','friends-only']
    image = ['default_food.jpg', 'default_food.jpg']

    # users.each { |user| user.recipes.create!( name: name,
    #                                           description: description,
    #                                           level: "3",
    #                                           course: course,
    #                                           prep_time: "10",
    #                                           cook_time: "20",
    #                                           serving: "1",
    #                                           ingredients: ingredients,
    #                                           directions: directions,
    #                                           privacy: privacy
    #                                           ) }

    users.each { |user| user.recipes.create!( name: name.sample,
                                              description: description,
                                              level: level.sample,
                                              course: course.sample,
                                              cook_time: cook_time.sample,
                                              serving: serving.sample,
                                              ingredients: ingredients,
                                              directions: directions,
                                              image: image.sample,
                                              privacy: privacy.sample
                                              
                                              ) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end