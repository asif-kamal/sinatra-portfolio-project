class Book < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  belongs_to :user
  has_many :book_languages


  validates :title, uniqueness: { case_sensitive: false }
  

end
