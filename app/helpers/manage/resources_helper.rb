module Manage
  module ResourcesHelper
    def prepare_cache resource = self
      # preprocess entries
      cache_dir = File.join Rails.root, 'tmp', 'resources'
      cache_file = File.join cache_dir, resource.bucket.name,
                             resource[:hash].first(2), resource[:hash]

      # prepare dir to write
      FileUtils.mkdir_p File.dirname(cache_file)

      cache_file
    end

    def retrieve_file resource = self, force = false
      cache_file = prepare_cache resource

      if force or not File.exists? cache_file
        # write to cache
        File.open(cache_file, "wb") do |target|
          resource.chunks.where(old: false).asc(:n).each do |chunk|
            target.write chunk.data.data
          end
        end
      end

      cache_file
    end
  end
end
