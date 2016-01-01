class Theme < ActiveRecord::Base
  validates_presence_of :name, :priority
  validates_uniqueness_of :name

  after_initialize :set_next_priority

  private

  def set_next_priority
    if self.id.nil?
      self.priority = Theme.maximum(:priority).to_i + 1
    end
  end
end
