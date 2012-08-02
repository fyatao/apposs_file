module AppossFile
  module Worker
    module Svn
      class << self

        def pre_scripts refer_url
          [
            "rm -rf target* && svn export #{refer_url} target",
            "cd target && tar cz . -f ../target.tgz && cd .. && rm -rf target"
          ]
        end

      end
    end
  end
end
