module Manage
  module ResourcesHelper
    def retrieve_file resource, force = false
      # preprocess entries
      cache_dir = File.join Rails.root, 'tmp', 'resources'
      cache_file = File.join cache_dir, resource.bucket.name, resource.path

      if force or not File.exists? cache_file
        # prepare dir to write
        FileUtils.mkdir_p File.dirname(cache_file)

        # write to cache
        target = File.open(cache_file, "wb")
        Mongoid::GridFS.get(resource.file_id).each { |chuck| target.write chuck }
      end

      cache_file
    end
  end
end
