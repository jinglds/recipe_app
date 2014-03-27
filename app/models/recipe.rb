class Recipe < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable
  

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy
  accepts_nested_attributes_for :ingredients, :allow_destroy => true, :reject_if => lambda { |a| a[:item].blank? }
  validates_associated :ingredients, presence: true

  accepts_nested_attributes_for :directions, :allow_destroy => true, :reject_if => lambda { |a| a[:content].blank? }
  validates_associated :directions, presence: true

  default_scope -> { order('created_at DESC') }
  validates :name, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  mount_uploader :image, ImageUploader
  # validates :image, presence: false

  scope :all_appetizers, where(course: 'appetizer')
  scope :all_mains, where(course: 'main')
  scope :all_desserts, where(course: 'dessert')
  scope :all_beverages, where(course: 'beverage')
  scope :unique_by_course, lambda { select('DISTINCT(course)') }
  scope :unique_by_level, lambda { select('DISTINCT(level)' ) }




  # Returns recipes from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end


  def comment_feed
    Comment.where("recipe_id =?", id)
  end






  # def self.search(search)
  #   if search
  #     where('name LIKE ?', "%#{search}%")
  #   else
  #     all
  #   end
  # end

#   def self.filtered_by_course(filter)
#     find(:all,
#     :conditions => "course LIKE ? #{filter}"
# )
#   end



  def self.filtered_appetizers
      all_appetizers
    
  end

  def self.filtered_mains
      all_mains
    
  end
  def self.filtered_desserts
      all_desserts
    
  end
  def self.filtered_beverages
      all_beverages
    
  end




  # def self.search(search)
  #   if search
  #     where('name LIKE ?', "%#{search}%")
  #   else
  #     where('name LIKE ?', "%#{}%")
  #   end
  # end

  # def self.search(search)
  #  if search
  #   find(:all, :conditions => ['first_name LIKE ? || last_name LIKE ? || company_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
  #  else
  #   find(:all)
  #  end
  # end
end
