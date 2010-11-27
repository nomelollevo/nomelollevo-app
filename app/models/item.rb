# -*- coding: utf-8 -*-
class Item < ActiveRecord::Base
  #associations
  belongs_to :sale

  #validations
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :price
  validates_presence_of :status
  validates_presence_of :category

  validate :price_is_positive
  validate :valid_status
  validate :valid_category

  # enumerations
  def self.valid_status
    ["sin estrenar",
     "usado",
     "deteriorado"].freeze
  end

  def self.categories
    ["electronica",
     "electrodomésticos",
     "muebles",
     "menaje",
     "comida",
     "ropa",
     "deporte",
     "libros",
     "otros"].freeze
  end

  # TODO: this is a delegate "like a cathedral"
  def province
    sale.province
  end

  def zip_code
    sale.zip_code
  end

  def address
    sale.address
  end

  def start_time
    sale.start_time
  end

  def end_time
    sale.end_time
  end

  def is_unlimited
    sale.is_unlimited
  end

  # validation functions

  def price_is_positive
    if(price < 0)
      errors_add(:price, "El precio no puede ser negativo")
    end
  end

  def valid_status
    unless Item.status.detect(status)
      errors_add(:status, "El estado del artículo no es válido")
    end
  end

  def valid_category
    unless Item.categories.detect(category)
      errors_add(:status, "La categoría del artículo no es válida")
    end
  end
end
