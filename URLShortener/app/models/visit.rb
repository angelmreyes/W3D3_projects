# == Schema Information
#
# Table name: visits
#
#  id           :bigint           not null, primary key
#  short_url_id :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Visit < ApplicationRecord
  validates :short_url_id, presence: true
  validates :user_id, presence: true


  def self.record_visit!(user_obj, short_url_obj)
    Visit.new(user_id: user_obj.id, short_url_id: short_url_obj.id).save!
  end

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :visited_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl
end
