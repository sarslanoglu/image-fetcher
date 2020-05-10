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

The ouput should start with something like `ruby 2.7.1`

If not, you can install the right ruby version using [rvm](https://github.com/rvm/rvm) (it could take a while) or use your own ruby version manager:

```shell
rvm install 2.7.1
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

If you provide more than one argument script will give you ArgumentError
Also if you give wrong or nonexisting path system will give you 'No such file or directory @ rb_sysopen'
In that case please take a look at your file path and make sure it is correctly given.

---------

Image fetcher

To learn more about the way you develop, we have a remote
assessment:

Given a plaintext file containing URLs, one per line, e.g.:
http://mywebserver.com/images/271947.jpg
http://mywebserver.com/images/24174.jpg
http://somewebsrv.com/img/992147.jpg

Write a command line script that takes this plaintext file as an
argument and downloads all images, storing them on the local hard
disk.
Approach the problem as you would any task in a normal day's work:
as if this code will be used in important live systems, modified
later on by other developers, and so on.
Please use Ruby for your solution. We prefer to receive your code
in GitHub.
Above all: have fun!