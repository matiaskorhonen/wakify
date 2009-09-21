# Authorization module
module Authorization
  # Extend ActiveRecord
  class ActiveRecord::Base
    # Check if the current user owns the object
    def access_allowed?(user)
      return user.id == self.user.id
    end
  end
end
