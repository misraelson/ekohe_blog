require 'rails_helper'

describe 'Blogs' do
  describe 'show' do
    let!(:user1) { User.create(id: 1, name: "Will Smith", email: "will@gmail.com", password: "independence") }
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
  describe 'toggle status' do
    let!(:user1) { User.create(id: 1, name: "Will Smith", email: "will@gmail.com", password: "independence", password_confirmation: "independence") }
    let(:blog) { Blog.create(title: "Pattern matching data enhancement", body: "Our new approach to data", status: "draft", user_id: user1.id) }
    it 'should toggle blog status' do
      sign_in user1
      get "/blogs/#{blog.slug}/toggle_status"
      expect(response).to redirect_to(blogs_url)
      expect_attributes blog.reload, status: "published"
    end
  end
end