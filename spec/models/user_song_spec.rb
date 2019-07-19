require 'rails_helper'

RSpec.describe UserSong, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:song) }
end
