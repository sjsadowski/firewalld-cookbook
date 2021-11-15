require 'spec_helper'

describe 'fixture::service' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'adds service http' do
    expect(chef_run).to add_firewalld_service('http')
  end

  it 'removes service telnet' do
    expect(chef_run).to remove_firewalld_service('telnet')
  end
end
