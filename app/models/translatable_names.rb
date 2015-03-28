module TranslatableNames
  # Get localized name of item
  #
  # @param [Symbol] locale
  # @return [String]
  def name(locale)
    method_name = "name_#{locale}"
    respond_to?(method_name) ? send(method_name) : slug
  end

  # Get localized description of item
  #
  # @param [Symbol] locale
  # @return [String]
  def description(locale)
    method_name = "description_#{locale}"
    respond_to?(method_name) ? send(method_name) : nil
  end
end