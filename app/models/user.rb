class User
  include Mongoid::Document
  devise :database_authenticatable, :rememberable,
         authentication_keys: [ :username ]

  ## Database authenticatable
  field :username,           type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Rememberable
  field :remember_created_at, type: Time

  field :name,               type: String, default: ""

  has_many :buckets

  index({ username: 1 }, { unique: true, background: 1 })
end
