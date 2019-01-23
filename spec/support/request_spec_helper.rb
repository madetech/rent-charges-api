module RequestSpecHelper
  def json_response
    JSON.parse(response.body) unless response.body.empty?
  end
end

