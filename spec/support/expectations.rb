def expect_attributes(object, attributes)
  attributes.each {|key, val| expect_attribute(object, key.to_s, val) }
end

def expect_attribute(object, attribute, expected)
  expect(object).to have_attribute(attribute), "Unrecognised attribute for #{object.class.name}: #{attribute}"
  actual = object.attributes[attribute]
  expect(values_match?(actual, expected)).to be(true), "Expected #{object.class.name} #{attribute} to be #{expected} but got #{actual}"
end

def values_match?(actual, expected)
  if expected == :nowish
    (actual - Time.current).abs < 2
  elsif expected.is_a?(Time)
    (actual - expected).abs < 2
  else
    actual == expected
  end
end

def it_should_redirect_with_permission_denied(method, urls, error, redirect_url = nil)

  redirect_url ||= login_path(anchor: 'login')

  urls.each do |url|
    send(method, "/#{url}")
    expect(response).to redirect_to(redirect_url), "Expected #{method} to URL #{url} to redirect to #{login_path}"
    expect(session).to contain_flash_error error, "Expected #{method} to URL #{url} to contain flash error #{error}"
  end
end