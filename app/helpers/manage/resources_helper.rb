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
        File.open(cache_file, "wb") do |target|
          Mongoid::GridFS.get(resource.file_id).each do |chuck|
            target.write chuck
          end
        end
      end

      cache_file
    end
  end
end
