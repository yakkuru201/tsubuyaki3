class Favorite < ActiveRecord::Base
  attr_accessible :tweet_id, :user_id
end
