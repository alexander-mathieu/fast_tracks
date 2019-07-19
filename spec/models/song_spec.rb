# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Song, type: :model do
  it { should have_many(:users) }
end
