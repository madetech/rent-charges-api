module RequestSpecHelper
  def json
    JSON.parse(response.body) unless response.body.empty?
  end
end