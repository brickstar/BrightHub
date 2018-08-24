class Repository
  attr_reader :name, :url
  def initialize(raw_repo)
    @name = raw_repo[:name]
    @url = raw_repo[:url]
  end
end
