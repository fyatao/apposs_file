class DirectiveGroup
  def self.where hsh
    self
  end

  def self.first
    new
  end

  def id; 0; end
  
  def self.find_or_create_by_name name
    new
  end
  
  def self.find_by_name name
    new
  end
end
