module TimeHelpers
  extend ActiveSupport::Concern

  included do
    def created_w3c
      created_at.strftime('%Y-%m-%dT%H:%M:%S%:z')
    end

    def updated_w3c
      updated_at.strftime('%Y-%m-%dT%H:%M:%S%:z')
    end

    def created_date
      created_at.strftime('%Y-%m-%d')
    end

    def updated_date
      updated_at.strftime('%Y-%m-%d')
    end
  end
end