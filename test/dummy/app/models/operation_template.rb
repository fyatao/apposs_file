class OperationTemplate < ActiveRecord::Base
  attr_accessible :app_id, :name, :source_ids, :begin_script
  belongs_to :app
end
