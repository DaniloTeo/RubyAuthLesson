# frozen_string_literal: true

module Api
  module V1
    # User ApplicationController API
    class UsersController < ApplicationController
      def create
        @user = User.create(user_params)

        if @user.save
          render json: { user: UserSerializer.new(@user) }, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
      end

      def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
      end

      def user_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end
