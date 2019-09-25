class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  # 実際にはUserクラスに、tasksというインスタンスメソッドを追加している
  # def tasks
  #   Task.where(user_id: self.id)
  # end
  # とほぼやっていることは同じ
  has_many :tasks
end
