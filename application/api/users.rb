class Api
  resource :users do
    post do
      result = CreateUserValidation.new(params).validate
      if result.success? && user = Models::User.create(result.output)
        mail = ::Mail.new do
          from     SYSTEM_EMAIL
          to       user.email
          subject  'Your account has been created successfully'
          body     'Need a nice body'
        end.deliver!
        Entities::User.represent(user)
      else
        error!(result.messages, 400)
      end
    end

    put ':id' do
      authenticate!
      user = Models::User[params[:id]]

      return error!('Unauthorized', 401) unless current_user.can?(:edit, user)

      result = EditUserValidation.new(params).validate
      if result.success?
        user.update(result.output)
        Entities::User.represent(user)
      else
        error!(result.messages, 400)
      end
    end

    patch ':id/reset_password' do
      authenticate!
      user = Models::User[params[:id]]

      return error!('Unauthorized', 401) unless current_user.can?(:edit, user)

      result = ResetPasswordUserValidation.new(params).validate

      if result.success?
        user.update(password: result.output[:new_password])
        mail = ::Mail.new do
          from     SYSTEM_EMAIL
          to       user.email
          subject  'Your password has been reset successfully'
          body     'Need a nice body'
        end.deliver!
        Entities::User.represent(user)
      else
        error!(result.messages, 400)
      end
    end
  end
end
