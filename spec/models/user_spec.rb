require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }



  # Shoulda tests for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  # Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
       expect(user).to have_attributes(name: user.name, email: user.email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

# #2
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

# #3
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
  # #4
    it "is member by default" do
      expect(user.role).to eql("member")
    end

  # #5
    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

  # #6
    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe "invalid user" do
     let(:user_with_invalid_name) { build(:user, name: "") }
     let(:user_with_invalid_email) { build(:user, email: "") }
     
    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "#favorite_for(post)" do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end

    it "returns `nil` if the user has not favorited the post" do
# #1
      expect(user.favorite_for(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
# #2
      favorite = user.favorites.where(post: @post).create
# #3
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
  
  describe ".avatar_url" do
    let(:known_user) { create(:user, email: "blochead@bloc.io") }
    
     it "returns the proper Gravatar url for a known email entity" do
      
       expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
       expect(known_user.avatar_url(48)).to eq(expected_gravatar)
   end
  end
  
    describe "#favorite_for_user(user)" do
      let(:user_without_favorites) { create(:user) }
      let(:post) { create(:post) }

      before do
        @favorite = user.favorites.create!(post_id: post.id)
      end
  
      it "returns empty array if the user has not favorited any posts" do
        expect(user_without_favorites.favorite_for_user(user_without_favorites)).to be_empty
      end
  
      it "returns all posts favorited by the user if any" do
        expect(user.favorite_for_user(user)).to include(@favorite)
      end
  end
end
