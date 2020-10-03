class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
   
    def task
        @task = params[:task]
        @user = @task.assignee
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Task assigned')
    end

end