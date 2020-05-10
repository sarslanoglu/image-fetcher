# frozen_string_literal: true

require 'fileutils'
require 'open-uri'

class ImageFetcher
  WHITELIST_IMAGE_EXTENSIONS = %w[].freeze

  def download(file_path)
    image_file_read_result = read_image_file(file_path)

    if image_file_read_result.include?('Caught the exception')
      p file_path_error(file_path, image_file_read_result)
    elsif image_file_read_result.include?('Unsupported file type')
      p file_type_error(check_file_type(file_path))
    elsif image_file_read_result.empty?
      p 'File is empty. Please add some urls'
    else
      p download_file(image_file_read_result)
    end
  end

  private

  def read_image_file(file_path)
    unless file_path.nil?
      raise ArgumentError if check_file_type(file_path) != 'txt'
    end

    file = if file_path.nil?
             File.open('lib/data/images_list.txt')
           else
             File.open(file_path)
           end
    file.readlines.map(&:chomp)
  rescue Errno::ENOENT => e
    "Caught the exception: #{e}"
  rescue ArgumentError
    'Unsupported file type'
  end

  def check_file_type(file_path)
    file_path.split('.').last
  end

  def file_path_error(file_path, result_message)
    error_message = "Couldn't read file located at '#{file_path}' "
    error_message += "Catched error is -> #{result_message} "
    error_message + 'Please make sure file exists and file_path is correct'
  end

  def file_type_error(file_type)
    "Provided file is a .#{file_type} file. Please provide .txt file"
  end

  def download_file(image_file)
    download_path = generate_random_download_path
    FileUtils.mkdir_p("downloads/#{download_path}")
    image_file.each_with_index do |line, index|
      if line.empty?
        p "Line #{index + 1} is empty. Skipping"
      elsif download_image(line, index, download_path) == 'downloaded'
        p "Line #{index + 1} succesfully downloaded"
      else
        download_result = download_image(line, index, download_path)
        p "Line #{index + 1} failed to download. Reason #{download_result[0]}"
      end
    end
    "Succesfully downloaded images are on file 'downloads/#{download_path}' path"
  end

  def download_image(url, index, random_download_path)
    URI.open(url) do |image|
      if content_image?(image.content_type)
        File.open("downloads/#{random_download_path}/image_#{index}.jpg", 'wb') do |file|
          file.write(image.read)
          return 'downloaded'
        end
      else
        ['link_is_not_image', index]
      end
    end
  rescue SystemCallError => e
    ['SystemCallError', e, index]
  rescue StandardError => e
    [e, index]
  end

  def content_image?(content_type)
    if content_type.split('/')[0] == 'image' ||
       WHITELIST_IMAGE_EXTENSIONS.include?(content_type.split('/')[1])
      true
    else
      false
    end
  end

  def generate_random_download_path
    (0...8).map { rand(65..90).chr }.join
  end
end
