class Sale < ActiveRecord::Base
  validates_presence_of :is_unlimited
  validates_presence_of :zip_code

  validate :not_blank_times_if_limited
  validate :end_time_in_the_future

  # validations

  def not_blank_times_if_limited
    if !is_unlimited && end_time.nil?
      errors.add(:end_time, "debes indicar la fecha de fin para ventas limitadas")
    end
    if !is_unlimited && start_time.nil?
      errors.add(:start_time, "debes indicar la fecha de inicio para ventas limitadas")
    end
  end

  def end_time_in_the_future
    if !is_unlimited && end_time && start_time && (end_time < start_time)
      errors.add(:end_time, "no puede ser anterior a la fecha de inicio")
    end
  end

end
