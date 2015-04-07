require 'spec_helper'

describe 'fixture::source' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it "adds source 192.168.0.0/24" do
    expect(chef_run).to add_firewalld_source("192.168.0.0/24")
  end

  it "removes source 192.168.0.0/24" do
    expect(chef_run).to remove_firewalld_source("192.168.0.0/24")
  end

end
