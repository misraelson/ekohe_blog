require 'rails_helper'

describe 'Blogs' do
  describe 'blog create' do
    let!(:user1) { User.create(id: 1, name: "Will Smith", email: "will@gmail.com", password: "independence", password_confirmation: "independence") }
    context 'user not signed in' do
      it 'should NOT create the blog' do
        post blogs_path, params: {blog: {title: "Pattern matching data enhancement", body: "Our new approach to data", status: "draft"}}
        expect(response).to redirect_to(new_user_session_path)
        expect(Blog.count).to eq 0
      end
    end
    context 'user signed in' do
      it 'should create the blog' do
        sign_in user1
        post blogs_path, params: {blog: {title: "Pattern matching data enhancement", body: "Our new approach to data", status: "draft", user_id: user1.id}}
        expect(response).to redirect_to(blog_url(Blog.last.slug))
        expect(Blog.count).to eq 1
        expect_attributes Blog.last,
          title: "Pattern matching data enhancement",
          body: "Our new approach to data",
          status: "draft"
      end
    end
  end
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
    context 'valid blog slug' do
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