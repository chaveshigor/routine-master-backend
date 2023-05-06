# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model

  def rescue_errors
    ActiveRecord::Base.transaction do
      yield
    rescue => exception
      false
    end
  end
end

