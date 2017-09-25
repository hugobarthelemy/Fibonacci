require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do
  describe 'valid user' do
    DatabaseCleaner.clean

    let(:valid_create) {
      User.create!(email: 'bob@gmail.com',
        first_name: 'Pi',
        last_name: 'Po',
        password: '123456',
        street: 'rue bidule',
        street_number: '42',
        city: 'Paris',
        zip: '75014')
    }

    it 'email & password valid' do
      expect(valid_create).to be_valid
    end
  end

  describe 'invalid user' do
    it 'password invalid but two same email' do
      user = User.create(email: 'titi@gmail.com',
          first_name: 'Pi',
          last_name: 'Po',
          password: '12345',
          street: 'rue bidule',
          street_number: '42',
          city: 'Paris',
          zip: '75014')
      expect(user).not_to be_valid
    end

    it 'two same email' do
      user = User.create(email: 'bob@gmail.com',
          first_name: 'Pi',
          last_name: 'Po',
          password: '123456',
          street: 'rue bidule',
          street_number: '42',
          city: 'Paris',
          zip: '75014')
      expect(user).not_to be_valid
    end

    it 'wrong email format' do
      user = User.create(email: 'truc',
          first_name: 'Pi',
          last_name: 'Po',
          password: '12345',
          street: 'rue bidule',
          street_number: '42',
          city: 'Paris',
          zip: '75014')
      expect(user).not_to be_valid
    end
  end
end
