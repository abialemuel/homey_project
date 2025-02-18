# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

for i in 1..5
  Project.create!(name: "Project #{i}", status: "pending")
end

# create a user
user = User.create!(name: "Alice", email: "alice@example.com")
# for each project create histories
for project in Project.all
  project.project_histories.create!(user: user, content: "Initial status set to pending", change_type: "status_change")
end
