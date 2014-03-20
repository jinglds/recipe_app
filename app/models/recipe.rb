class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :name, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  mount_uploader :image, ImageUploader
  # validates :image, presence: false


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
end
