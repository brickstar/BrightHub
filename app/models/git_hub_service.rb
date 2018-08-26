class GitHubService
  def initialize(current_user)
    @login = current_user.login
    @token = current_user.token
  end

  def repositories
    @repositories ||= get_json("/users/#{@login}/repos")
  end

  def user_json
    @user_json ||= get_json('user')
  end

  private

  def conn
    @conn ||= Faraday.new("https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
