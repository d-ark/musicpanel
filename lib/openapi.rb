class Openapi
  attr_accessor :bpm, :energy, :colors, :q, :request

  class NetworkError < StandardError
  end

  def initialize args
    args.each do |k,v|
      send "#{k}=", v
    end
  end

  def get_tracks limit = 10, skip = 0
    @request = {}
    value_request :bpm
    value_request :energy
    colors_request
    search_request
    skip_limit_request limit, skip

    perform_request.parsed_response['tracks']
  end

  private
    def value_request name
      if send(name)
        @request[name] = {
            from: send(name)[:from],
            to: send(name)[:to]
          }
      end
    end

    def colors_request
      if colors
        @request[:colors] ||= {}
        colors.each do |color, value|
          @request[:colors][color] = {
              from: value[:from],
              to: value[:to]
            }
        end
      end
    end

    def search_request
      if @q
        @request = {q: @q}
      end
    end

    def perform_request
      HTTParty.get 'http://api.randrmusic.com/api/search/tracks', query: @request, headers: {'x-api-auth' => ENV['RANDR_API_KEY']}
    end

    def skip_limit_request limit, skip
      @request[:limit] = limit
      @request[:offset] = skip
    end
end
