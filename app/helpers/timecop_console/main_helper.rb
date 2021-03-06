module TimecopConsole
  module MainHelper
    def time_travel_to(date)
      unless date.respond_to?(:year) && date.respond_to?(:month) && date.respond_to?(:day)
        raise ArgumentError, "Argument must be a Date object"
      end

      update_path = timecop_console.update_path(timecop: {
        'current_time(1i)' => date.year,
        'current_time(2i)' => date.month,
        'current_time(3i)' => date.day,
        'current_time(4i)' => 12,
        'current_time(5i)' => 0
      })

      button_to(date.strftime("%B %d, %Y"),
                update_path,
                method: :post)
    end
  end
end
