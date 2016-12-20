if defined?(ChefSpec)
  def add_firewalld_interface(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_interface, :add, name)
  end

  def change_firewalld_interface(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_interface, :change, name)
  end

  def remove_firewalld_interface(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_interface, :remove, name)
  end

  def add_firewalld_port(port)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_port, :add, port)
  end

  def remove_firewalld_port(port)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_port, :remove, port)
  end

  def add_firewalld_rich_rule(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_rich_rule, :add, name)
  end

  def remove_firewalld_rich_rule(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_rich_rule, :remove, name)
  end

  def add_firewalld_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_service, :add, name)
  end

  def remove_firewalld_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_service, :remove, name)
  end

  def add_firewalld_source(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_source, :add, name)
  end

  def change_firewalld_source(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_source, :change, name)
  end

  def remove_firewalld_source(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_source, :remove, name)
  end

  def create_firewalld_zone(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_zone, :create, name)
  end

  def delete_firewalld_zone(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_zone, :delete, name)
  end

  def add_firewalld_masquerade(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_masquerade, :add, name)
  end

  def remove_firewalld_masquerade(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_masquerade, :remove, name)
  end
end
