class Bucket
  include Mongoid::Document

  field :name,      type: String, default: ""
  validates_presence_of :name, message: '空间名称不能为空'
  validates_uniqueness_of :name, message: '空间名称已使用，请尝试其他名称'
  validates_format_of :name, with: /\A[a-z][a-z0-9\-]{2,}\z/,
    message: '空间名由字母开头，可包含字母、数字、-(减号)，并至少 3 个字符，请尝试其他名称。'

  field :hash_type, type: Symbol, default: :md5

  has_many :resources, dependent: :destroy
  belongs_to :user

  index({ path: 1 }, { unique: true, background: 1 })
end
