# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'SecureRandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  def self.random_code
    code = SecureRandom.urlsafe_base64
    code = SecureRandom.urlsafe_base64 while (ShortenedUrl.exists?(short_url: code))
    code
  end

  def self.create_surl(user_obj, lurl)
    surl = ShortenedUrl.random_code
    id = user_obj.id
    ShortenedUrl.new(short_url: surl, long_url: lurl, user_id: id)
  end

  def num_clicks
    self.vistors.count
    # self.vistors.select(:user_id)
  end

  def num_uniques
    #self.visitors.uniq.count
    self.vistors.select(:user_id).distinct
  end

  def num_recent_uniques

  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :visitor
end
