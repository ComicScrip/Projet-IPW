class User < ApplicationRecord
  has_many :teached_disciplines, class_name: 'Discipline', inverse_of: 'owner', foreign_key: 'owner_id'
  has_and_belongs_to_many :studied_disciplines, class_name: 'Discipline'
  has_many :exams, through: :assessments

  validates :firstName, presence: true
  validates :lastName, presence: true

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end
end