class CpuTemperature < ActiveRecord::Base
  attr_accessible :temperature, :time

  def average_temperature
    self.class.average(:temperature).to_i / 10
  end

  def count_temperature
    self.class.count(:temperature).to_i
  end
end
