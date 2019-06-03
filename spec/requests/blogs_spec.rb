require 'rails_helper'

describe 'Blogs' do
  include RSpecHtmlMatchers
  let!(:user1) { User.create(id: 1, name: "Will Smith", email: "will@gmail.com", password: "independence") }
  describe 'show' do
    let(:blog) { Blog.create(title: "Pattern matching data enhancement", body: "Our new approach to data predictions yields 80% exact", status: 1, user_id: user1.id) }
    context 'invalid slug' do
      it 'should render the not found page' do
        get "/blogs/Pattern-something"
        expect(response.status).to eq 200
        expect(response).to match_html('span', 'article not found')
      end
    end
    context 'valid blog' do
      it 'should render the blog page' do
        get "/blogs/#{blog.slug}"
        expect(response.status).to eq 200
        expect(response).to match_html('h2', "Title: PATTERN MATCHING DATA ENHANCEMENT")
        expect(response).to match_html('p', "Our new approach to data predictions yields 80% exact")
      end
    end
  end
end