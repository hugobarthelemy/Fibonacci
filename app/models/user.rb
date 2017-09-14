class User < ApplicationRecord
  include Clearance::User
  include AASM

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, length: { minimum: 6 }
  validates :zip, presence: true, length: { minimum: 5 }
  validates :city, presence: true
  validates :email, presence: true, format: { with: /\A.*@.*\.com\z/ }, uniqueness: true

  aasm do
    state :loaded, :initial => true
    state :profile_details
    state :technical_details

    event :fill_basic_info do
      transitions :from => :loaded, :to => :profile_details, :guard => Proc.new { |o|
      o.valid?
    }
    end

    event :fill_skills do
      transitions :from => :profile_details, :to => :technical_details
    end


    event :previous_step do
      transitions :from => :technical_details, :to => :profile_details
      transitions :from => :profile_details, :to => :loaded
    end
  end

  def change_ad_next_state
    case self.aasm_state
    when 'loaded'
      fill_basic_info
    when 'profile_details'
      fill_skills
    end
  end
end
