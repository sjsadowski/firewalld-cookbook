require 'spec_helper'

describe 'fixture::interface' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it "adds interface eth0" do
    expect(chef_run).to add_firewalld_interface("eth0")
  end

  it "removes interface eth0" do
    expect(chef_run).to remove_firewalld_interface("eth0")
  end

end
