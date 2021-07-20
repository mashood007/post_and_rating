# frozen_string_literal: true

require './models/application_model'
class Rating < ApplicationModel
  TABLE = 'ratings'

  def initialize(params, rate)
    @columns = 'rate, post_id'
    @attributes = params
    @table_name = TABLE
    @rate = rate.to_i
  end

  def save
    if (1..5).include?(@rate)
      super
      ['Success', '200 OK']
    else
      ['Validation failed', '422 ERROR']
    end
  end
end
