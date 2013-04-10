# MrGithub

A tool for generating [mr](http://joeyh.name/code/mr/) a config that includes all GitHub repositories you can access. This makes it really easy to checkout and update all repositories you can access with a few commands.

## Installation

Install it yourself as:

    $ gem install mr_github

## Usage


mr_github reads from a configuration at ~/.mr_github. It needs two configs like:

    GITHUB_USERNAME=yourusername
    GITHUB_PASSWORD=yourpassword

When those are set, there's a single command:

    $ mr_github generate

This creates ~/.mrconfig containing all repositories the GITHUB_USER can access. You'll need mr installed to actually do the checkout. Most package managers have it available as the mr package:

    $ sudo apt-get install mr
    $ brew install mr

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
