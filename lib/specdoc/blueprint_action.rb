module Specdoc
  class BlueprintAction
    ALLOWED_HEADERS = %w(HTTP_AUTHORIZATION AUTHORIZATION)
    ALPHABET = ('A'..'Z').to_a

    attr_accessor :request_method, :identifier

    def initialize(request_method, identifier)
      @request_method = request_method
      @identifier = identifier
      @examples = []
    end

    def add_transaction_example(request, response, title)
      @examples << {
        request: render_request(request),
        response: render_response(response),
        mime_type: request_content_type(request),
        title: title
      }
    end

    def render_examples
      each_request_with_reponse do |request, response, title|
        "+ #{title}\n\n#{request}\n\n#{response}"
      end.join("\n\n")
    end

    def render_request(request)
      [
        request_parameters(request),
        request_headers(request),
        request_body(request)
      ].compact.join("\n\n")
    end

    def render_response(response)
      buffer = "+ Response #{response.status} (#{response.content_type}; charset=#{response.charset})\n\n"

      return buffer unless response.body.present? && json_mime_type == response.content_type.to_s
      buffer << "#{JSON.pretty_generate(JSON.parse(response.body))}\n\n".indent(8)
    end

    def to_s
      "### #{identifier} [#{request_method}]\n\n" +
        render_examples
    end

    private

    def request_content_type(request)
      request.env['CONTENT_TYPE'] || request.content_type
    end

    def request_headers(request)
      env = request.env || request.headers
      headers = env.map do |header, value|
        next unless ALLOWED_HEADERS.include?(header)
        header = header.gsub(/HTTP_/, '')
        header = header.gsub(/\ACONTENT_TYPE\z/, 'CONTENT-TYPE')
        "#{header}: #{value}".indent(12)
      end.compact
      return unless headers.any?
      "+ Headers\n\n".indent(4) + headers.join("\n")
    end

    def request_body(request)
      request_body = request.body.read
      # Request Body
      return '' unless request_body.present? && json_mime_type == request.content_type.to_s
      "+ Body\n\n".indent(4) +
        JSON.pretty_generate(JSON.parse(request.body.read)).indent(12)
    end

    def request_parameters(request)
      return unless request.env['QUERY_STRING'].present?
      params = "+ Parameters\n\n".indent(4)
      query_strings = URI.decode(request.env['QUERY_STRING']).split('&')

      query_strings.each do |value|
        key, example = value.split('=')
        params << "+ #{key} = '#{example}'\n".indent(12)
      end
      params
    end

    def each_request_with_reponse
      include_suffix = @examples.count > 1
      @examples.each_with_index.map do |example, index|
        title_suffix = include_suffix ? title_suffix(index + 1) : ''
        title = "Request #{example[:title] || title_suffix} (#{example[:mime_type]})"
        yield example[:request], example[:response], title
      end
    end

    # Returns a sequence of letters for a given number, eg:
    # 1 => "A"
    # 2 => "B"
    # 26 => "Z"
    # 27 => "AA"
    # 28 => "AB"
    def title_suffix(i)
      s = ''
      until i.zero?
        i, r = (i - 1).divmod(26)
        s.prepend(ALPHABET[r])
      end
      s
    end

    def json_mime_type
      @json_mime_type ||= Mime::Type.lookup('application/json')
    end
  end
end
