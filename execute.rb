# frozen_string_literal: true

require './lib/image_fetcher'

if ARGV.length > 1
  raise ArgumentError, "Too many arguments provided. Given #{ARGV.length}, supported 0..1"
end

image_fetcher = ImageFetcher.new
image_fetcher.download(ARGV[0])
