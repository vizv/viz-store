class User
  include Mongoid::Document

  ## Database authenticatable
  field :username,           type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :name,               type: String, default: ""

  has_many :buckets

  index({ username: 1 }, { unique: true, background: 1 })
end
