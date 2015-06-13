class Resource
  include Mongoid::Document
  include Manage::ResourcesHelper

  field :filename,    type: String
  validates_presence_of   :filename, message: '文件名不能为空'
  validates_uniqueness_of :filename, message: '文件名已使用，请尝试其他文件名'
  validates_format_of     :filename, without: /\A\/|\/\//,
    message: '文件名不能以 / 开头，并且之间不能包含连续的两个 /，请尝试其他名称。'

  field :length,      type: Integer,  default: 0
  field :chunk_size,  type: Integer,  default: 4 * (mib = 2**20)
  field :upload_date, type: Time,     default: Time.now.utc
  field :hash,        type: String,   default: ''
  field :hash_type,   type: Symbol,   default: :md5
  field :contentType, type: String,   default: 'application/octet-stream'
  has_many :chunks, dependent: :destroy

  def file= file
    @file = file
  end

  def file
    @file
  end

  attr_reader :file

  before_save do |document|
    # ignore update chunk
    next if document.file.nil?

    # prepare chunks for recovery
    document.chunks.where(old: true).destroy rescue nil
    document.chunks.update_all old: true

    n = 0

    begin
      digest = case document.hash_type
        when :md5 then Digest::MD5.new
        when :sha256 then Digest::SHA256.new
        else Digest::MD5.new
      end

      io = document.file
      # TODO: set content type

      # build chunks for current resource
      while buf = io.read(document.chunk_size)
        digest << buf
        document.length += buf.size
        chunk_data = BSON::Binary.new buf, :generic
        chunk = document.chunks.new n: n, data: chunk_data
        n += 1
        chunk.save!
      end

      document.hash = digest.hexdigest

      # cache it
      src = File.expand_path document.file.path
      dest = prepare_cache document
      FileUtils.cp src, dest
    rescue
      # recover old chunks
      document.chunks.where(old: false).destroy rescue nil
      document.chunks.update_all old: false
      raise
    end
  end

  belongs_to :bucket

  index({ bucket_id: 1, filename: 1 }, { unique: true, background: 1 })

  def path
    "/#{self.bucket.name}/#{self.filename}"
  end
end
