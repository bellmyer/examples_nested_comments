require 'spec_helper'

def mock_post(stubs={})
  (@mock_post ||= mock_model(Post).as_null_object).tap do |post|
    post.stub(stubs) unless stubs.empty?
  end
end

describe PostsController do
  describe "GET index" do
    before do
      Post.should_receive(:all).and_return([mock_post])
      get :index
    end
    
    it { should assign_to(:posts).with([mock_post])}
    it { should respond_with :success }
    it { should render_template :index }
    it { should_not set_the_flash }
  end
  
  describe "GET show" do
    before do
      Post.should_receive(:find).with('1001').and_return(mock_post)
      get :show, :id => '1001'
    end
    
    it { should assign_to(:post).with(mock_post) }
    it { should respond_with :success }
    it { should render_template :show }
    it { should_not set_the_flash }
  end
  
  describe "GET new" do
    before do
      Post.should_receive(:new).and_return(mock_post)
      get :new
    end
    
    it { should assign_to(:post).with(mock_post) }
    it { should respond_with :success }
    it { should render_template :new }
    it { should_not set_the_flash }
  end
  
  describe "POST create" do
    describe "with valid data" do
      before do
        Post.should_receive(:new).with('these' => 'params').and_return(mock_post(:save => true))
        post :create, :post => {'these' => 'params'}
      end
      
      it { should assign_to(:post).with(mock_post) }
      it { should redirect_to posts_path }
      it { should set_the_flash.to /success/i }
    end
    
    describe "with invalid data" do
      before do
        Post.should_receive(:new).with('these' => 'params').and_return(mock_post(:save => false))
        post :create, :post => {'these' => 'params'}
      end
      
      it { should assign_to(:post).with(mock_post) }
      it { should respond_with :success }
      it { should render_template :new }
      it { should_not set_the_flash }
    end
  end
  
  describe "GET edit" do
    before do
      Post.should_receive(:find).with('1001').and_return(mock_post)
      get :edit, :id => '1001'
    end
    
    it { should assign_to(:post).with(mock_post) }
    it { should respond_with :success }
    it { should render_template :edit }
    it { should_not set_the_flash }
  end
  
  describe "PUT update" do
    describe "with valid data" do
      before do
        Post.should_receive(:find).with('1001').and_return(mock_post)
        mock_post.should_receive(:update_attributes).with('these' => 'params').and_return(true)
        
        put :update, :id => '1001', :post => {'these' => 'params'}
      end
      
      it { should assign_to(:post).with(mock_post) }
      it { should redirect_to post_path(mock_post) }
      it { should set_the_flash.to /success/i }
    end
  end
end
