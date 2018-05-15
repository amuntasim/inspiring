require "administrate/field/base"

class GmapCoordinateField < Administrate::Field::Base
  def to_s
    data
  end
end
