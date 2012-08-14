module AppossFile
  module Worker
    module Svn
      class << self

        def pre_scripts refer_url, download_folder
          [
            "rm -rf target",
            "rm -rf #{download_folder}/target.tgz",
            "svn export #{refer_url} target",
            "cd target && tar cz . -f #{download_folder}/target.tgz",
            "rm -rf target"
          ]
        end

      end
    end
  end
end
