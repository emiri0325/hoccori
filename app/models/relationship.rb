class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
                      # User クラスを参照するものだと明示
end
