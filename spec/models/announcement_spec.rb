require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
  end

  describe 'associations' do
    it { should belong_to :author }
  end
end
