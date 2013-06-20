require Rails.root.join('spec/factories/user')
require Rails.root.join('spec/factories/page')

p '     -------------------    SEED DATA    ------------------- '

2.times do
  user = FactoryGirl.create(:user)
  p "Content Provider: #{user.username}/#{user.password}"
  3.times { FactoryGirl.create(:page, user: user) }
end

admin = FactoryGirl.create(:admin)
p "Admin: #{admin.username}/#{admin.password}"
