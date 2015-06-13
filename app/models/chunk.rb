class Chunk
  include Mongoid::Document

  field :n,     type: Integer, default: 0
  field :data,  type: BSON::Binary
  field :old,   type: Boolean, default: false

  index({ files_id: 1, n: -1, old: 1 }, unique: true)

  belongs_to :resource
end
