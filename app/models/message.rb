class Message < ActiveRecord::Base
  attr_accessible :contents, :context, :flat_id, :from_id, :received, :to_id

  validates :from_id, :contents, :presence => true
  belongs_to :flat
end
