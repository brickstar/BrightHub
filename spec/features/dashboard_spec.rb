require 'rails_helper'

describe 'user visits homepage' do
  before(:each)  do
    user_fixture =  File.read('./spec/fixtures/user.json')
    repos = File.read('./spec/fixtures/repos.json')

    stub_request(:get, "https://api.github.com/user")
    .with(headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization'=>"token #{ENV['TEST_TOKEN']}",
                'User-Agent'=>'Faraday v0.12.2'
                        })
    .to_return(status: 200, body: user_fixture, headers: {})

    stub_request(:get, "https://api.github.com/users/brickstar/repos")
    .with(headers: {
            'Accept'=>"*/*",
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"token #{ENV['TEST_TOKEN']}",
            'User-Agent'=>'Faraday v0.12.2'
                    })
    .to_return(status: 200, body: repos, headers: {})
  end
  xit 'can login' do
    visit root_path

    stub_omniauth

    visit('/')

    click_on 'Sign in with GitHub'

    expect(page).to have_content('Hello Matt Bricker')
    expect(page).to have_link('Logout')
  end

  it 'shows a profile' do
    user_fixture =  File.read('./spec/fixtures/user.json')
    repos = File.read('./spec/fixtures/repos.json')

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_index_path

    expect(page).to have_content('Repositories: 57')
  end

  it 'shows a list of repositories' do
    user_fixture =  File.read('./spec/fixtures/user.json')
    repos = File.read('./spec/fixtures/repos.json')

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_index_path

    expect(page).to have_css('.repository', count: 30)

    within(first('.repository')) do
      expect(page).to have_css('.repo-name')
      expect(page).to have_css('.repo-url')
    end
  end

end
