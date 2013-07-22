class Permission < ActiveRecord::Base
                ## Who,   How,     What
  attr_accessible :user, :action, :thing

  belongs_to :user # shortcut for user, class_name: User, foreign_key: :user_id
  belongs_to :thing, polymorphic: true #each association will
    #have options so convention says put a new line
end
