module ActiveAdmin
  module ProductsHelper
    def color_for_type(type)
      case type
      when 'small'   then :green
      when 'large'   then :red
      when 'medium'  then :orange
      when 'default' then :gray
      end
    end
  end
end
