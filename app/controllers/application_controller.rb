class ApplicationController < ActionController::Base
    before_action :set_project_new_instance
    
    private
        def set_project_new_instance
          @project_new = Project.new
        end

end
