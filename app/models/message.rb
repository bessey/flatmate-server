class Message < ActiveRecord::Base
  attr_accessible :contents, :context, :flat_id, :from_id, :received, :to_id

  belongs_to :flat
end
