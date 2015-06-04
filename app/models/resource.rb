class Resource
  include Mongoid::Document

  field :path, type: String
  validates_presence_of :path, message: '文件名不能为空'
  validates_uniqueness_of :path, message: '文件名已使用，请尝试其他文件名'
  validates_format_of :path, without: /\/\/|^\//,
    message: '文件名不能以 / 开头，并且之间不能包含连续的两个 /，请尝试其他名称。'

  mount_uploader :file, ResourceUploader

  belongs_to :bucket

  index({ bucket_id: 1, path: 1 }, { unique: true, background: 1 })

  def link
    "/#{self.bucket.name}/#{self.path}"
  end
end
