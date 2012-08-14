# encoding: utf-8
class App < ActiveRecord::Base
  attr_accessible :name
  scope :reals, order(:name) # 添加一个空的 scope 
  has_many :operation_templates

  def public_folder
    "/public/data/#{id}"
  end

  def private_folder
    "/private/data/#{id}"
  end

  def make_command title, command, begin_script
    directive_template = DirectiveTemplate.create!(
      :alias    => title,
      :name     => command, 
      :directive_group_id => 0,
      :owner_id => 0
    )

    operation_template = operation_templates.create!(
      name:         title,
      source_ids:   ["#{directive_template.id}|false"],
      begin_script: begin_script
    ) 
    return directive_template,operation_template
  end

end
