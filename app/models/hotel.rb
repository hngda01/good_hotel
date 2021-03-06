class Hotel < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_hotel_name, against: [:name],
    using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, dependent: :destroy

  def self.filter_by_service(params)
    services = params.keys & ["wifi", "pool", "breakfast", "parking"]
    hotels = Hotel.all
    services.each do |service|
      hotels = hotels.where(service, true)
    end
    return hotels
  end
end
