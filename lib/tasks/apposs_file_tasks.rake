# encoding: utf-8
# desc "Explaining what the task does"
# task :apposs_file do
#   # Task goes here
# end
#
namespace "apposs_file" do

  desc "更新文件同步任务，使用新的脚本"
  task :update_command => :environment do
    AppossFile::FileEntry.find_each do |entry|
      entry.clean_resource
      entry.build_resource
      entry.directive_template.update_attribute(:name, entry.command)
    end
  end

  desc "更新文件同步项，补充关联外键"
  task :fulfill_referer => :environment do
    AppossFile::FileEntry.find_each do |entry|
      group = DirectiveGroup.find_by_name "app:#{entry.app.name}"

      directive_template = DirectiveTemplate.where(
        :directive_group_id => group.id,
        :alias              => "sync #{File.basename entry.refer_url}"
      ).first
      operation_template = entry.app.operation_templates.where(
        :name => "sync: #{entry.path}"
      ).first

      entry.update_attributes(
        operation_template_id: operation_template.id,
        directive_template_id: directive_template.id
      )
    end
  end

  desc "更新现有wget指令，简化输出"
  task :ignore_wget_stdout => :environment do
    DirectiveTemplate.find_each do |dt|
      if dt.name =~ /wget/
        dt.name = dt.name.gsub /wget/, 'wget --quiet'
        dt.save!
      end
    end
  end
end
