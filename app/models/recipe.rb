class Recipe < ActiveRecord::Base
  has_many :user_favorites
  has_many :notes
  # has_many :users through: :user_favorites

  def json_with_note_ids
    JSON.parse(to_json({methods: :note_ids}))
  end
end