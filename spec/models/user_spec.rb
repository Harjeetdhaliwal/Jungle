require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should create a user if it passes all the validations' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user.save
      expect(@user.errors).not_to include(/confirmation doesn't match Password/)
    end


    it 'should not create a user if password and password_confirmation does not match' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "test1346")
      @user.valid?
      expect(@user.errors.full_messages).to include(/confirmation doesn't match Password/)
    end

    it 'should not create a user if password field is empty' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com")
      @user.valid?
      expect(@user.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not create a user if first name is missing' do
      @user = User.new(last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user.valid?
      expect(@user.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not create a user if last name is missing' do
      @user = User.new(name: "Harjeet", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user.valid?
      expect(@user.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not create a user if email is missing' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", password: "Test123", password_confirmation: "Test123")
      @user.valid?
      expect(@user.errors.full_messages).to include(/can't be blank/)
    end

    it 'should not create a user if password length is less than 5 characters' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test", password_confirmation: "Test")
      @user.valid?
      expect(@user.errors.full_messages).to include(/Password is too short/)
    end

    it 'should not create a user if email already exits in database' do
      @user1 = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user1.save
      @user2 = User.new(name: "Kaur", last_name: "Harjeet", email: "harjeet@mail.com", password: "Hello123", password_confirmation: "Hello123")
      @user2.save
      expect(@user2.errors.full_messages).to include(/Email has already been taken/)
    end

    it 'should not create a user if email already exits but in capital letters' do
      @user1 = User.new(name: "Harjeet", last_name: "Kaur", email: "HARJEET@MAIL.COM", password: "Test123", password_confirmation: "Test123")
      @user1.save
      @user2 = User.new(name: "Kaur", last_name: "Harjeet", email: "harjeet@mail.com", password: "Hello123", password_confirmation: "Hello123")
      @user2.save
      expect(@user2.errors.full_messages).to include(/Email has already been taken/)
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate user if email and password is correct' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user.save
      @findUser = User.authenticate_with_credentials("harjeet@mail.com", "Test123")
      expect(@findUser).to be_present
    end

    it 'should not authenticate user if email does not exists' do
      @findUser = User.authenticate_with_credentials("harjeet@mail.com", "Test123")
      expect(@findUser).to be_nil
    end

    it 'should authenticate user if email has some capital letters' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user.save
      @findUser = User.authenticate_with_credentials("haRjeEt@mAiL.com", "Test123")
      expect(@findUser).to be_present
    end

    it 'should authenticate user if email has extra white spaces' do
      @user = User.new(name: "Harjeet", last_name: "Kaur", email: "harjeet@mail.com", password: "Test123", password_confirmation: "Test123")
      @user.save
      @findUser = User.authenticate_with_credentials("harjeet@mail.com  ", "Test123")
      expect(@findUser).to be_present
    end
  end

end
