# rake db:drop && rake db:create && rake db:migrate && rake db:seed

User.destroy_all

admin_user = FactoryBot.create(:user, email: 'admin@example.com', name: 'admin', password: '123456', user_type: 1, auto_confirm: true)
user1      = FactoryBot.create(:user, auto_confirm: true)
user2      = FactoryBot.create(:user, auto_confirm: true)
user3      = FactoryBot.create(:user, auto_confirm: true)
user4      = FactoryBot.create(:user, auto_confirm: true)


Category.destroy_all
cat1 = FactoryBot.create(:category, for: "story")
cat2 = FactoryBot.create(:category, for: "story")
cat3 = FactoryBot.create(:category, for: "story")
cat4 = FactoryBot.create(:category, for: "story")
cat5 = FactoryBot.create(:category, for: "brand")
cat6 = FactoryBot.create(:category, for: "brand")
cat7 = FactoryBot.create(:category, for: "brand")
cat8 = FactoryBot.create(:category, for: "brand")


Tag.destroy_all
tag1 = FactoryBot.create(:tag)
tag2 = FactoryBot.create(:tag)
tag3 = FactoryBot.create(:tag)
tag4 = FactoryBot.create(:tag)
tag5 = FactoryBot.create(:tag, category: "brand")
tag6 = FactoryBot.create(:tag, category: "brand")
tag7 = FactoryBot.create(:tag, category: "brand")
tag8 = FactoryBot.create(:tag, category: "brand")

Brand.destroy_all
10.times do |index|
  FactoryBot.create(:brand,
                    user:     [user1, user2, user3, user4].sample,
                    category: [cat5, cat6, cat7, cat8].sample,
                    tags:     [tag5, tag6, tag7, tag8].sample(rand(3))
  )
end

Story.destroy_all
50.times do |index|
  FactoryBot.create(:story,
                    user:     [user1, user2, user3, user4].sample,
                    category: [cat1, cat2, cat3, cat4].sample,
                    tags:     [tag1, tag2, tag3, tag4].sample(rand(3))
  )
end

p "Seeding completed"
