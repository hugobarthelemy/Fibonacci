require "rails_helper"
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.describe UserMailer, type: :mailer do
  describe 'send a vild mail' do
    DatabaseCleaner.clean
    user = User.create!(email: 'hello@gmail.com',
        first_name: 'Pi',
        last_name: 'Po',
        password: '123456',
        street: 'rue bidule',
        street_number: '42',
        city: 'Paris',
        zip: '75014',
        aasm_state: :second_step_of_form)
    mail = UserMailer.welcome(user)

    it 'renders the subject' do
      expect(mail.subject).to eq("Welcome at Enercoop !")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['contact@enercoop.fr'])
    end
  end
end
