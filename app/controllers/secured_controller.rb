# frozen_string_literal: true

class SecuredController < ApiController
  before_action :authenticate_user
end
