require "administrate/field/base"

class HiddenCountryCityMapField < Administrate::Field::Base
  def to_s
    data
  end
end
