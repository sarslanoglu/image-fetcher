# frozen_string_literal: true

require_relative '../lib/image_fetcher'

describe 'image_fetcher' do
  before(:all) do
    FileUtils.mkdir_p('downloads/TESTPATH')
  end

  after(:all) do
    FileUtils.remove_dir('downloads/TESTPATH')
  end

  context '.download' do
    it 'should download images in images_list.txt' do
      image_fetcher = ImageFetcher.new
      allow(image_fetcher).to receive(:generate_random_download_path).and_return('TESTPATH')

      expect(image_fetcher.download('spec/example_image_files/images_list.txt'))
        .to eq("Succesfully downloaded images are on file 'downloads/TESTPATH' path")
    end

    it 'should not download images_list.txt due to path_error' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.download('lib/spec/data/unknown/images_list.txt'))
        .to include("Couldn't read file located at 'lib/spec/data/unknown/images_list.txt'")
    end

    it 'should not download museum.jpeg due to file type error' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.download('spec/example_image_files/museum.jpeg'))
        .to eq('Provided file is a .jpeg file. Please provide .txt file')
    end

    it 'should not download empty_list.txt due to empty content' do
      image_fetcher = ImageFetcher.new
      allow(image_fetcher).to receive(:generate_random_download_path).and_return('TESTPATH')

      expect(image_fetcher.download('spec/example_image_files/empty_list.txt'))
        .to eq('File is empty. Please add some urls')
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
        .to eq(['https://i.picsum.photos/id/237/200/300.jpg', '',
                'https://i.picsum.photos/id/456/1000/1500.jpg', 'https://www.test.com/test3.pdf'])
    end

    it 'should not read given different file rather than .txt' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:read_image_file, 'lib/spec/data/unknown/images_list.pdf'))
        .to eq('Unsupported file type')
    end

    it 'should not read given txt file if path is incorrect with params' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:read_image_file, 'lib/spec/data/unknown/images_list.txt'))
        .to include('Caught the exception: No such file or directory @ rb_sysopen')
    end
  end

  context '.download_image' do
    it 'downloads image from provided url', :vcr do
      image_fetcher = ImageFetcher.new
      test_url = 'https://i.picsum.photos/id/237/200/300.jpg'

      expect(image_fetcher.send(:download_image, test_url, 0, 'TESTPATH')).to eq('downloaded')
    end

    it 'returns error when content type is not image', :vcr do
      image_fetcher = ImageFetcher.new
      test_url = 'https://www.test.com/test3.pdf'

      expect(image_fetcher.send(:download_image, test_url, 0, 'TESTPATH'))
        .to eq(['link_is_not_image', 0])
    end

    it 'returns error when internal system fails', :vcr do
      image_fetcher = ImageFetcher.new
      test_url = 'https://i.picsum.photos/id/456/1000/1500.jpg'
      allow(image_fetcher).to receive(:download_image).and_raise(SystemCallError.new('error'))

      expect do
        image_fetcher.send(:download_image, test_url, 0, 'TESTPATH')
      end.to raise_error(SystemCallError)
    end
  end

  context '.content_image?' do
    it 'returns true if content type is image' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:content_image?, 'image/png')).to eq(true)
    end

    it 'returns true if content type is whitelisted' do
      stub_const 'ImageFetcher::WHITELIST_IMAGE_EXTENSIONS', %w[pdf].freeze
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:content_image?, 'application/pdf')).to eq(true)
    end

    it 'returns false if content type is not included' do
      image_fetcher = ImageFetcher.new

      expect(image_fetcher.send(:content_image?, 'application/pdf')).to eq(false)
    end
  end

  context '.generate_random_download_path' do
    it 'generates 8 char random strings every time' do
      image_fetcher = ImageFetcher.new
      first_key = image_fetcher.send(:generate_random_download_path)

      expect(image_fetcher.send(:generate_random_download_path)).to_not eq(first_key)
    end
  end
end
