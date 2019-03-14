module ActiveAdmin
  module OrdersHelper
    def color_for_status(status)
      case status
      when 'Pending'    then :red
      when 'Complete'   then :green
      when 'Processing' then :orange
      end
    end
  end
end
