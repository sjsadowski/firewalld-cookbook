require 'spec_helper'

describe 'fixture::zone' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it "creates zone testzone" do
    expect(chef_run).to create_firewalld_zone("testzone")
  end

  it "deletes zone testzone" do
    expect(chef_run).to delete_firewalld_zone("testzone")
  end

end
