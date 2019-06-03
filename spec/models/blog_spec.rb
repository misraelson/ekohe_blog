require 'rails_helper'

describe Blog do
  let!(:user1) { User.create(id: 1, name: "Will Smith", email: "will@gmail.com", password: "independence" )}
  describe 'search' do
    let!(:b1) { Blog.create(title: "DOT-COM bubbles", body: Faker::Movies::StarWars.quote, status: 0, user_id: user1.id)}
    let!(:b2) { Blog.create(title: "IMPLEMENT DOT-COM CHANNELS", body: Faker::Movies::StarWars.quote, status: 0, user_id: user1.id)}
    let!(:b3) { Blog.create(title: "ENABLE CUTTING-EDGE CONTENT", body: Faker::Movies::StarWars.quote, status: 1, user_id: user1.id)}
    specify { expect(Blog.search('dot-com')).to eq([b1, b2]) }
    specify { expect(Blog.search('Content')).to eq([b3]) }
  end
end