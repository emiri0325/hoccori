class User < ApplicationRecord
  before_save { self.email.downcase! }    
  validates :name, presence: true, length: { maximum: 50 } 
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }  
  has_secure_password
  
  has_many :posts
  
  # 自分がフォローしているUserへの参照 
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  # 自分をフォローしているUserへの参照
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
 # お気に入り機能追加
  has_many :favorites
  has_many :likes, through: :favorites, source: :post

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end 
  
  # お気に入りメソッド
  def like(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end
  
  def unlike(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end  
  
  def like?(post)
    self.likes.include?(post)
  end  
  
end
