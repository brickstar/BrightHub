class Profile
  def initialize(user)
    @service = GitHubService.new(user)
  end

  def repositories
    @service.repositories.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end

  def avatar
    @service.user_json[:avatar_url]
  end

  def repository_count
    @service.user_json[:public_repos]
  end
end
