require 'spec_helper'

describe 'fixture::zone' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it "enables, and starts firewalld service" do
    expect(chef_run).to enable_service('firewalld')
    expect(chef_run).to start_service('firewalld')
  end

  it "creates zone zone1" do
    expect(chef_run).to create_firewalld_zone("zone1")
  end

  it "deletes zone zone2" do
    expect(chef_run).to delete_firewalld_zone("zone2")
  end

end
