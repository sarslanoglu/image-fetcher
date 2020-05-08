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

## Instructions

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