if defined?(ChefSpec)
  def add_firewalld_port(port)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_port, :add, port)
  end

  def remove_firewalld_port(port)
    ChefSpec::Matchers::ResourceMatcher.new(:firewalld_port, :remove, port)
  end
end
