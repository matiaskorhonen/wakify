module Authorization
  class ActiveRecord::Base
    def access_allowed?(user)
      return user.id == self.user.id
    end
  end
end
