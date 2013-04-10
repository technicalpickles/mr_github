#!/usr/bin/env ruby
require 'bundler/setup'

require 'ghee'
require 'pry'
require 'dotenv'
require 'thor'

Dotenv.load "#{ENV['HOME']}/.mr_github"

module MrGithub

  class MrConfig
    def initialize(github_user, github_password)
      @gh = Ghee.basic_auth(github_user, github_password)
    end

    def config
      @config ||= begin
                    @config = StringIO.new

                    user = @gh.user

                    @config.puts "# That #{user.login} has access to directly"
                    @gh.user.repos.all.each do |repo|
                      @config.puts "[src/#{repo.owner.login.to_s}/#{repo.name.to_s}]"
                      @config.puts "checkout = git clone #{repo.ssh_url.to_s}"
                      @config.puts ""
                    end

                    @gh.orgs.each do |org|
                      @config.puts "# That #{user.login} has access to via #{org.login}"
                      @gh.orgs(org.login).repos.all.each do |repo|
                        next if repo == ["message", "Not Found"]
                        next if repo.name == 'rails' # don't need people's forks of rails
                        @config.puts "[src/#{repo.owner.login.to_s}/#{repo.name.to_s}]"
                        @config.puts "checkout = git clone #{repo.ssh_url.to_s}"
                        @config.puts ""
                      end

                    end

                    @config.string
                  end
    end

    def to_s
      config.to_s
    end
  end

  class App < Thor
    include Thor::Actions

    desc 'generate', 'Generate a ~/.mrconfig from GitHub repositories you can access'
    def generate
      github_user = ENV['GITHUB_USER']
      if github_user.nil? || github_user.empty?
        raise Thor::Error, "Missing GITHUB_USER in ~/.mr_github. Add a line like GITHUB_USER=yourusername and try again"
      end

      github_password = ENV['GITHUB_PASSWORD']
      if github_password.nil? || github_password.empty?
        raise Thor::Error, "Missing GITHUB_PASSWORD in ~/.mr_github. Add a line like GITHUB_PASSWORD=yourpassword and try again"
      end

      mr_config = MrConfig.new(github_user, github_password)
      say "Generating .mrconfig with repositories #{github_user} can access"

      create_file "#{ENV['HOME']}/.mrconfig", mr_config.to_s
    end
  end
end
