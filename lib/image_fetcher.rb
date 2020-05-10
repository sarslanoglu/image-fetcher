# frozen_string_literal: true

class ImageFetcher
  def download(file_path)
    image_file_read_result = read_image_file(file_path)

    if image_file_read_result.include?('Caught the exception')
      error_message = "Couldn't read file located at '#{file_path}' "
      error_message += "Catched error is -> #{image_file_read_result} "
      error_message += 'Please make sure file exists and file_path is correct'
      p error_message
    else
      image_file_read_result.each do |line|
        # Do image download stuff
      end
    end
  end

  private

  def read_image_file(file_path)
    file = if file_path.nil?
             File.open('lib/data/images_list.txt')
           else
             File.open(file_path)
           end
    file.readlines.map(&:chomp)
  rescue Errno::ENOENT => e
    "Caught the exception: #{e}"
  end
end
