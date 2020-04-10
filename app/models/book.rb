class Book < ActiveRecord::Base

  belongs_to :user
  has_many :languages, through: :book_languages



  validates :title, uniqueness: { case_sensitive: false }


end
