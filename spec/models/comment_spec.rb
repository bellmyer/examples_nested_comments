require 'spec_helper'

describe Comment do
  it { should belong_to :commentable }
  it { should have_many :comments }
  
  describe "post" do
    before do
      @post = Post.create
      @comment = @post.comments.create
    end
    
    it "should find the root post if it's the direct parent" do
      @comment.post.should == @post
    end
    
    it "should find the root post even if it's several levels up" do
      comment2 = @comment.comments.create
      comment3 = comment2.comments.create
      
      comment3.post.should == @post
    end
    
    it "should cache the result in an instance variable" do
      @comment.post.should == @post
      @comment.should_receive(:commentable).never
      @comment.post.should == @post
    end
  end
end
