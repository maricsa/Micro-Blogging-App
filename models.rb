class User < ActiveRecord::Base
	has_many :posts
end

class Posts < ActiveRecord::Base
	belongs_to :user
end