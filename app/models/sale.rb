# -*- coding: utf-8 -*-
class Sale < ActiveRecord::Base

  # associations

  belongs_to :user
  has_many   :items

  # validations

  validates_presence_of :zip_code, :message => "Debes indicar un código postal"
  validates_presence_of :province, :message => "Debes indicar la provincia"
  validates_presence_of :longitude, :message => "Debe tener una longitud geográfica"
  validates_presence_of :latitude, :message => "Debe tener una latitud geográfica"

  validate :value_for_is_unlimited
  validate :not_blank_times_if_limited
  validate :end_time_in_the_future

  # validation functions

  def not_blank_times_if_limited
    if !is_unlimited && end_time.nil?
      errors.add(:end_time, "Debes indicar la fecha de fin para ventas limitadas")
    end
    if !is_unlimited && start_time.nil?
      errors.add(:start_time, "Debes indicar la fecha de inicio para ventas limitadas")
    end
  end

  def value_for_is_unlimited
    unless is_unlimited == true || is_unlimited == false
      errors.add(:is_unlimited, "Debes indicar si la venta esta límitada temporalmente o no")
    end
  end

  def end_time_in_the_future
    if !is_unlimited && end_time && start_time && (end_time < start_time)
      errors.add(:end_time, "La fecha de fin no puede ser anterior a la fecha de inicio")
    end
  end

  # logic

  def total_price
    items.reduce(0){|t,i| t += i.price}
  end
end
