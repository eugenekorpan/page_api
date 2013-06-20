require Rails.root.join('spec/factories/user')

p '     -------------------    SEED DATA    ------------------- '

2.times do
  user = FactoryGirl.create(:user)
  p "Content Provider: #{user.username}/#{user.password}"
end

admin = FactoryGirl.create(:admin)
p "Admin: #{admin.username}/#{admin.password}"
