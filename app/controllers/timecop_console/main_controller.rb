module TimecopConsole
  class MainController < ::ApplicationController
    skip_around_action :handle_timecop_offset

    def update
      if date_select_format?
        year   = params['timecop']['current_time(1i)']
        month  = params['timecop']['current_time(2i)']
        day    = params['timecop']['current_time(3i)']
        hour   = params['timecop']['current_time(4i)']
        minute = params['timecop']['current_time(5i)']
        second = Time.now.sec
      else
        # backward compatible format
        year   = params[:year]
        month  = params[:month]
        day    = params[:day]
        hour   = params[:hour]
        minute = params[:min]
        second = params[:sec]
      end

      session[SESSION_KEY_NAME] = Time.zone.local(year, month, day, hour, minute, second)

      #because
      #root_path
      #ActionController::UrlGenerationError: No route matches {:action=>"root", :controller=>"home"}
      redirect_back fallback_location: '/'
    end

    def reset
      session[SESSION_KEY_NAME] = nil

      #because
      #root_path
      #ActionController::UrlGenerationError: No route matches {:action=>"root", :controller=>"home"}
      redirect_back fallback_location: '/'
    end

    private

      # http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html#method-i-date_select
      def date_select_format?
        params['timecop'].present? && params['timecop']['current_time(1i)'].present?
      end
  end
end
