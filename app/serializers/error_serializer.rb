# frozen_string_literal: true

class ErrorSerializer
  def initialize(form_errors)
    @form_errors = form_errors
  end

  def serializable_hash
    {
      data: {
        type: :error,
        errors: form_errors.to_hash
      }
    }
  end

  private

  attr_reader :form_errors
end

