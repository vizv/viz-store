class Resource
  include Mongoid::Document

  field :path, type: String
  validates :path, presence: true, uniqueness: true,
                   format: { without: /\/\/|^\// }

  mount_uploader :file, ResourceUploader

  belongs_to :bucket

  index({ path: 1 }, { unique: true, background: 1 })
end
