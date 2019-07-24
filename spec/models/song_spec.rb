# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Song, type: :model do
  context 'relationships' do
    it { should have_many(:users) }
  end

  context 'instance methods' do
    it '#formatted_length' do
      song = create(:song, length: 143397)
      expect(song.formatted_length).to eq('2:23')
    end
  end
end
