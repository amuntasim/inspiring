# frozen_string_literal: true

class BasePresenter < SimpleDelegator
  def initialize(object, template)
    @object = object
    @template = template
  end

private

  def h
    @template
  end
end
