# frozen_string_literal: true

module Api
  module V1
    # AuthController < ApplicationController
    class AuthController < ApplicationController
      skip_before_action :authorized, only: [:create]

      def create
        @user = User.find_by(username: user_login_params[:username])

        # authenticate method comes from bcrypt
        # if @user && @user.authenticate(user_login_params[:password])
        if @user&.authenticate(user_login_params[:password])
          token = encode_token({ user_id: @user.id })
          render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
        else
          render json: { message: 'Invalid username or password' }, status: :unauthorized
        end
      end

      private

      def user_login_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end
