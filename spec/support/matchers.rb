require 'rspec/expectations'

RSpec::Matchers.define :have_content_in_order do |*texts|
  match do |content|
    regexp = texts.map { |text| Regexp.escape(text) }.join('.*')
    content =~ Regexp.compile(regexp)
  end
end