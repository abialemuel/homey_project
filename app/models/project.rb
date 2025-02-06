class Project < ApplicationRecord
  has_many :project_histories, dependent: :destroy
end
