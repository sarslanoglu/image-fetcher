# frozen_string_literal: true

require_relative '../lib/image_fetcher'

describe 'image_fetcher' do
  context 'test file' do
    it 'should print test text' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.download).to eq('All logic will be here')
    end
  end
end
