require 'rspec/expectations'

RSpec::Matchers.define :match_html do |path, text|
  match do |response|
    html = response.is_a?(String) ? response : response.body
    document = Nokogiri::HTML(html)
    nodes = document.css(path).map {|node| node.inner_html.gsub(/\n/, ' ').strip }
    nodes.any? {|node| node == text }
  end
  failure_message do |response|
    html = response.is_a?(String) ? response : response.body
    document = Nokogiri::HTML(html)
    nodes = document.css(path).map {|node| node.inner_html.gsub(/\n/, ' ').strip }
    "expected\n#{text}\nto match one of:\n#{nodes.join("\n")}"
  end
end