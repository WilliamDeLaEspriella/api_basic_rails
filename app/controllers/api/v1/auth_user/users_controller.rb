class Api::V1::AuthUser::UsersController < ApplicationController
    skip_before_action :authenticate_request
    
        def signup
            @user = User.new(user_params)
        
            if @user.save
                authenticate
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        end
        
        def login
         authenticate
        end
        
    
    
    private
        def authenticate 
            command = AuthenticateUser.call(params[:user][:email], params[:user][:password]) 
            if command.success? 
                render json: { auth_token: command.result } 
            else render json: { error: command.errors }, status: :unauthorized 
            end 
        end
        # Only allow a trusted parameter "white list" through.
        def user_params
          params.require(:user).permit(:email, :password,:password_confirmation)
        end

end
