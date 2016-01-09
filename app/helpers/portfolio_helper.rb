module PortfolioHelper
  def link_to_theme(theme, text = nil)
    link_to text || theme.name, portfolio_theme_path(theme: theme.slug)
  end
end
