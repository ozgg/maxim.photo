# frozen_string_literal: true

# Authentication token
#
# Attributes:
#   active [boolean]
#   agent_id [Agent], optional
#   created_at [DateTime]
#   ip_address_id [IpAddress], optional
#   last_used [datetime]
#   updated_at [DateTime]
#   user_id [User]
#   token [string]
class Token < ApplicationRecord
  include Biovision::Checkable
  include Biovision::HasOwner
  include Biovision::HasTrack
  include Biovision::Toggleable

  TOKEN_LIMIT = 255

  toggleable :active

  has_secure_token

  belongs_to :user
  validates_uniqueness_of :token
  validates_length_of :token, maximum: TOKEN_LIMIT

  scope :recent, -> { order('last_used desc nulls last') }
  scope :active, ->(f) { where(active: f.to_i.positive?) unless f.blank? }
  scope :filtered, ->(f) { with_user_id(f[:user_id]).active(f[:active]) }
  scope :list_for_administration, -> { recent }
  scope :list_for_owner, ->(u) { owned_by(u).recent }

  # @param [Integer] page
  # @param [Hash] filter
  def self.page_for_administration(page = 1, filter = {})
    filtered(filter).list_for_administration.page(page)
  end

  # @param [User] user
  # @param [Integer] page
  def self.page_for_owner(user, page = 1)
    list_for_owner(user).page(page)
  end

  def self.entity_parameters
    %i[active]
  end

  def self.creation_parameters
    entity_parameters + %i[user_id]
  end

  # @param [String] input
  def self.[](input)
    find_by(token: input.to_s.split(':')[1].to_s)
  end

  # @param [String] input
  def self.user_by_token(input)
    return if input.blank?

    pair = input.split(':')
    user_by_pair(pair[0].to_i, pair[1])
  end

  # @param [Integer] user_id
  # @param [String] token
  def self.user_by_pair(user_id, token)
    instance = find_by(user_id: user_id, token: token, active: true)
    return if instance.nil?

    instance.update_columns(last_used: Time.now)
    instance.user
  end

  def name
    "[#{id}] #{user.slug}"
  end

  def text_for_link
    name
  end

  # @param [User] user
  def editable_by?(user)
    owned_by?(user)
  end

  def cookie_pair
    "#{user_id}:#{token}"
  end
end