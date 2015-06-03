class Resource
  include Mongoid::Document

  field :path, type: String
  validates :name, presence: true, uniqueness: true,
                   format: { with: /[^\/].*/, without: /\/\// }

  mount_uploader :file, ResourceUploader

  belongs_to :bucket

  index({ path: 1 }, { unique: true, background: 1 })
end
