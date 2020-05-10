# frozen_string_literal: true

require_relative '../lib/image_fetcher'

describe 'image_fetcher' do
  context '.download' do
    it 'should download images in images_list.txt' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.download(nil)).to_not eq(nil)
    end

    it 'should not download images_list.txt due to path_error' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.download('lib/spec/data/unknown/images_list.txt'))
        .to include("Couldn't read file located at 'lib/spec/data/unknown/images_list.txt'")
    end
  end

  context '.read_image_file' do
    it 'should read default images_list.txt without params' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:read_image_file, nil)).to_not eq(nil)
    end

    it 'should read given txt file if path is correct with params' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:read_image_file, 'spec/example_image_files/images_list.txt'))
        .to eq(['https://www.test.com/test1.jpg', 'https://www.test.com/test2.jpg',
                'https://www.test.com/test3.jpg'])
    end

    it 'should not read given txt file if path is incorrect with params' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:read_image_file, 'lib/spec/data/unknown/images_list.txt'))
        .to include('Caught the exception: No such file or directory @ rb_sysopen')
    end
  end
end
