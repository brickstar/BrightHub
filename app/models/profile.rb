class Profile
  def initialize(user)
    @user = user
  end

  def user_json
    @user_json ||= get_json('user')
  end

  def avatar
    user_json[:avatar_url]
  end

  def repository_count
    user_json[:public_repos]
  end

  def repositories_json
    @repositories_json ||= get_json("/users/#{@user.login}/repos")
  end

  def repositories
    repositories_json.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end

  private

  def conn
    @conn ||= Faraday.new("https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{@user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

end
