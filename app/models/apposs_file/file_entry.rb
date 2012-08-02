require 'fileutils'

module AppossFile
  class FileEntry < ActiveRecord::Base

    validates_uniqueness_of :path, :refer_url, :scope => :app_id
    validates_presence_of :path, :refer_url, :refer_type, :app_id

    belongs_to :app
    belongs_to :directive_template
    belongs_to :operation_template

    after_create  :init_resource
    after_destroy :clean_resource

    def basedir;    "/apposs_file/#{app_id}/#{id}"   end
    def full_path;  "#{Rails.root}/public#{basedir}" end

    def worker
      case refer_type
      when 'svn'
        Worker::Svn
      when 'git'
        Worker::Git
      end
    end

    def init_resource
      FileUtils.mkdir_p full_path
      
      Dir.chdir full_path do
        worker.init_scripts(refer_url).each do |script|
          Rails.logger.info `#{script}`
        end
      end if worker.respond_to? :init_scripts
      
      directive_template, operation_template = make_command
      self.update_attributes(
        :directive_template_id => directive_template.id,
        :operation_template_id => operation_template.id
      )
    end

    def clean_resource
      FileUtils.rm_rf full_path
      operation_template.delete if operation_template
      directive_template.delete if directive_template
    end

    def pre_action
      Dir.chdir full_path do
        worker.pre_scripts(refer_url).each do |script|
          Rails.logger.info `#{script}`
        end
      end
    end
    
    def make_command
      app.make_command(
        "sync #{File.basename refer_url}##{id}",
        command(basedir,path,linkable),
        "AppossFile::FileEntry.find(#{id}).pre_action"
      )
    end

    def command basedir,path,linkable
      url = "#{Rails.configuration.base_url}/#{basedir}/target.tgz"
      if linkable
        [
          "export now=`date +%Y-%m-%d_%H-%M-%S`",
          "export path=`dirname #{path}`/$now",
          "mkdir -p $path",
          "cd $path",
          "wget --quiet \"#{url}\"",
          "tar xzf target.tgz",
          "rm target.tgz",
          "cd ..",
          "rm -rf #{path}",
          "ln -s $now #{path}"
        ].join(' && ')
      else
        [
          "mkdir -p #{path}",
          "cd #{path}",
          "rm -rf *",
          "wget --quiet \"#{url}\" && tar xzf target.tgz",
          "rm target.tgz"
        ].join(' && ')
      end
    end

    attr_accessible :refer_url, :refer_type, :path, :linkable
    attr_accessible :app_id
    attr_accessible :directive_template_id, :operation_template_id
  end
end
