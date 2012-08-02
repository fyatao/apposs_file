module AppossFile
  module Worker
    module Git
      class << self
        def init_scripts refer_url
          [ "git clone #{refer_url} target" ]
        end

        def pre_scripts refer_url
          [
            "rm -rf target.tgz && cd target && git pull",
            "cd target && tar cz . --exclude=.git -f ../target.tgz"
          ]
        end
      end
    end
  end
end
