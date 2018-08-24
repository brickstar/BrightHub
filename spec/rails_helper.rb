# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    {"provider"=>"github",
 "uid"=>"33355897",
 "info"=>{"nickname"=>"brickstar", "email"=>"brickstar@gmail.com", "name"=>"Matt Bricker", "image"=>"https://avatars2.githubusercontent.com/u/33355897?v=4", "urls"=>{"GitHub"=>"https://github.com/brickstar", "Blog"=>""}},
 "credentials"=>{"token"=>ENV["TEST_TOKEN"], "expires"=>false},
 "extra"=>
  {"raw_info"=>
    {"login"=>"brickstar",
     "id"=>33355897,
     "node_id"=>"MDQ6VXNlcjMzMzU1ODk3",
     "avatar_url"=>"https://avatars2.githubusercontent.com/u/33355897?v=4",
     "gravatar_id"=>"",
     "url"=>"https://api.github.com/users/brickstar",
     "html_url"=>"https://github.com/brickstar",
     "followers_url"=>"https://api.github.com/users/brickstar/followers",
     "following_url"=>"https://api.github.com/users/brickstar/following{/other_user}",
     "gists_url"=>"https://api.github.com/users/brickstar/gists{/gist_id}",
     "starred_url"=>"https://api.github.com/users/brickstar/starred{/owner}{/repo}",
     "subscriptions_url"=>"https://api.github.com/users/brickstar/subscriptions",
     "organizations_url"=>"https://api.github.com/users/brickstar/orgs",
     "repos_url"=>"https://api.github.com/users/brickstar/repos",
     "events_url"=>"https://api.github.com/users/brickstar/events{/privacy}",
     "received_events_url"=>"https://api.github.com/users/brickstar/received_events",
     "type"=>"User",
     "site_admin"=>false,
     "name"=>"Matt Bricker",
     "company"=>nil,
     "blog"=>"",
     "location"=>nil,
     "email"=>nil,
     "hireable"=>nil,
     "bio"=>nil,
     "public_repos"=>57,
     "public_gists"=>7,
     "followers"=>2,
     "following"=>0,
     "created_at"=>"2017-11-03T17:07:12Z",
     "updated_at"=>"2018-08-23T03:37:57Z",
     "private_gists"=>9,
     "total_private_repos"=>0,
     "owned_private_repos"=>0,
     "disk_usage"=>9893,
     "collaborators"=>0,
     "two_factor_authentication"=>false,
     "plan"=>{"name"=>"free", "space"=>976562499, "collaborators"=>0, "private_repos"=>0}}}})
    end

    begin
      ActiveRecord::Migration.maintain_test_schema!
    rescue ActiveRecord::PendingMigrationError => e
      puts e.to_s.strip
      exit 1
    end
    RSpec.configure do |config|
      # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
      config.fixture_path = "#{::Rails.root}/spec/fixtures"

      # If you're not using ActiveRecord, or you'd prefer not to run each of your
      # examples within a transaction, remove the following line or assign false
      # instead of true.
      config.use_transactional_fixtures = true

      # RSpec Rails can automatically mix in different behaviours to your tests
      # based on their file location, for example enabling you to call `get` and
      # `post` in specs under `spec/controllers`.
      #
      # You can disable this behaviour by removing the line below, and instead
      # explicitly tag your specs with their type, e.g.:
      #
      #     RSpec.describe UsersController, :type => :controller do
      #       # ...
      #     end
      #
      # The different available types are documented in the features, such as in
      # https://relishapp.com/rspec/rspec-rails/docs
      config.infer_spec_type_from_file_location!

      # Filter lines from Rails gems in backtraces.
      config.filter_rails_from_backtrace!
      config.include FactoryBot::Syntax::Methods
      config.before(:each) do
        WebMock.reset!
      end
      # arbitrary gems may also be filtered via:
      # config.filter_gems_from_backtrace("gem name")
    end
