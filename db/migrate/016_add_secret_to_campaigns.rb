class AddSecretToCampaigns < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :status, :string, :default => 'draft'    
    add_column :campaigns, :secret, :string
  end

  def self.down
    remove_column :campaigns, :secret
    remove_column :campaigns, :status
  end
end
