# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_one_attached :avatar

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_many :relationships, dependent: :destroy
  has_many :reverse_of_relationships, dependent: :destroy, class_name: 'Relationship', foreign_key: 'follow_id', inverse_of: :user
  has_many :followings, through: :relationships, source: :follow
  has_many :followers, through: :reverse_of_relationships, source: :user

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) if self != other_user
  end

  def unfollow(other_user)
    relationships.find_by(follow_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
