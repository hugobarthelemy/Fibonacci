class User < ApplicationRecord
  include Clearance::User
  include AASM

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :zip, presence: true, length: { minimum: 5 }
  validates :city, presence: true
  validates :email, presence: true, format: { with: /\A.*@.*\.com\z/ }, uniqueness: true

  aasm do
    state :first_step_of_form, initial: true
    state :second_step_of_form
    state :form_is_completed

    event :fill_the_first_step_of_form do
      transitions from: :first_step_of_form, to: :second_step_of_form
    end

    event :fill_the_second_step_of_form do
      transitions from: :second_step_of_form, to: :form_is_completed
    end

    event :back_to_the_first_step_fo_form do
      transitions from: :second_step_of_form, to: :first_step_of_form
    end
  end

  def change_ad_next_state
    case self.aasm_state
    when 'first_step_of_form'
      fill_the_first_step_of_form
    when 'second_step_of_form'
      fill_the_second_step_of_form
    when 'back_to_the_first_step_fo_form'
      back_to_the_first_step_fo_form
    end
  end
end
