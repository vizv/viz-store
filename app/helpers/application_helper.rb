module ApplicationHelper
  def retrieve_file file
    cache_dir = File.join Rails.root, 'tmp', 'resources'
    cache_file = File.join cache_dir, f.model.bucket.name, f.model.path
    FileUtils.mkdir_p File.dirname(cache_file)
    # Resource.first.file.file.grid_file.each { |chuck| t.write chuck }
  end
end
