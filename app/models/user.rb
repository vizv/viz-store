class User
  include Mongoid::Document
  include BCrypt

  ## Database authenticatable
  field :username,           type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :name,               type: String, default: ""

  has_many :buckets, dependent: :destroy

  def password= password
    self.encrypted_password = Password.create password
  end

  attr_reader :password

  index({ username: 1 }, { unique: true, background: 1 })
end
