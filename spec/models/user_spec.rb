require 'rails_helper'

RSpec.describe User, type: :model do

  describe "attributes" do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:username) }
    it { should have_db_column(:email) }
    it { should have_db_column(:password_digest) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
  end

  describe "associations" do
    it {should have_many(:games)}
    # it {should have_many(:games).with_foreign_key('user_id').class_name('Game')}
  end
end
