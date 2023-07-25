# frozen_string_literal: true

module Biovision
  module HasTrack
    extend ActiveSupport::Concern

    included do
      belongs_to :agent, optional: true
      belongs_to :ip_address, optional: true
    end
  end
end
