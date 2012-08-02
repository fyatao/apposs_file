class DirectiveTemplate < ActiveRecord::Base
  attr_accessible :alias, :name, :directive_group_id, :owner_id

  def gen_directive params
    "generate direcitve - name: #{self.name}, params: #{params}"
  end
end
