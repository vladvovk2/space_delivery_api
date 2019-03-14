module ActiveAdmin
  module ProductsHelper
    def color_for_type(type)
      case type
      when 'small'
        :green
      when 'medium'
        :orange
      when 'default'
        :gray
      when 'large'
        :red
      end
    end
  end
end
