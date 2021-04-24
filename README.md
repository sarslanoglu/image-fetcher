## Install

### Clone the repository

```shell
git clone git@github.com:sarslanoglu/image-fetcher.git
cd image-fetcher
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should be `ruby 3.0.0`

If not, you can install the right ruby version using [rvm](https://github.com/rvm/rvm) (it could take a while) or use your own ruby version manager:

```shell
rvm install 3.0.0
```

### Install dependencies

If you are want to use [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

## To run script

```shell
ruby execute.rb
```

## Testing

For rubocop to run

```shell
rubocop
```

For rspec to run

```shell
bundle exec rspec
```

After running rspec coverage file will be created locally. To open coverage file just type

```shell
open coverage/index.html
```

to the terminal and hit enter. New browser tab will be open.

Important note: Please do not delete lib/data/images_list.txt. If you are not going to use it, just empty file content.

## Instructions

Image fetcher is a ruby script which can download images from world wide web by providing a plain text file to it or by just updating existing images_list.txt just below lib/data folder.

If you want to use default images_list.txt update file and run

```shell
ruby execute.rb
```

If you want to use another file from your local run

```shell
ruby execute.rb 'path/to/your/file/that/contains/images.txt'
```

If you provide more than one argument script will give you ArgumentError.
Also if you give wrong or nonexisting path system will give you 'No such file or directory @ rb_sysopen'
In that case please take a look at your file path and make sure it is correctly given.

If given file is seen as correct input by program your download process will be start.
Every time an item is downloaded message like this will appear in terminal.

```
"Line #{line_number} succesfully downloaded"
```

If the line is empty line message will be

```
"Line #{line_number} is empty. Skipping"
```

If there is an error terminal will give an error message. It will specify which line caused which error and continue downloading rest of lines.

```
"Line #{line_number} failed to download. Reason link_is_not_image"
```

During script run if there is any other errors. It will give out in terminal also.

Each time when download start random 8 character will be generated for download file path. This way large quantity of images can be downloaded without overwriting each other. When download is finished this path is printing out to the terminal like this for reference.

```
"Succesfully downloaded images are on file 'downloads/CWDXVTSQ' path"
```

If other file types rather than images are wanted to be download by script constant ```WHITELIST_IMAGE_EXTENSIONS``` at ```ImageFetcher``` class can be updated. [Content types](https://www.freeformatter.com/mime-types-list.html)
