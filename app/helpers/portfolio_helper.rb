module PortfolioHelper
  def link_to_theme(theme)
    link_to theme.name, portfolio_theme_path(theme: theme.slug)
  end
end
