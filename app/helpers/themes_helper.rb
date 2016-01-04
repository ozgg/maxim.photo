module ThemesHelper
  def themes_for_select
    Theme.ordered_by_name.map { |theme| [theme.name, theme.id] }
  end
end
