if defined?(ChefSpec)
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
end
