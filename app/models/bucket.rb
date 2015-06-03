class Bucket
  include Mongoid::Document

  field :name,               type: String, default: ""

  has_many :resources
  belongs_to :user
end
