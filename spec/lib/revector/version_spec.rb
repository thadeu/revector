# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Revector do
  it 'must have a version number' do
    expect(described_class::VERSION).to eq('0.1.2')
  end
end
