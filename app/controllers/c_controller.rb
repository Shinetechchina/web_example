class CController < BaseController
  def say
    "say in CController" + C.new.say
  end
end

