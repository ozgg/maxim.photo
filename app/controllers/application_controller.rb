class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_page, :param_from_request, :current_user

  # Получить текущую страницу из запроса
  #
  # @return [Integer]
  def current_page
    @current_page ||= (params[:page] || 1).to_s.to_i.abs
  end

  # Получить параметр из запроса и нормализовать его
  #
  # Приводит параметр к строке в UTF-8 и удаляет недействительные символы
  #
  # @param [Symbol] param
  # @return [String]
  def param_from_request(param)
    params[param].to_s.encode('UTF-8', 'UTF-8', invalid: :replace, replace: '')
  end

  # Получить текущего пользователя из id в сессии
  #
  # @return [User|nil]
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
