# -*- coding: utf-8 -*-
class Item < ActiveRecord::Base
  #associations
  belongs_to :sale

  #validations
  validates_presence_of :title, :message       => "Es necesario indicar un título"
  validates_presence_of :description, :message => "Es necesario indicar una descripción"
  validates_numericality_of :price, :message   => "Es necesario indicar un valor numérico para el precio"
  validates_presence_of :price, :message       => "Es necesario indicar un precio"
  validates_presence_of :status, :message      => "Es necesario indicar un estado"
  validates_presence_of :category, :message    => "Es necesario seleccionar una categoría"

  validate :price_is_positive
  validate :valid_status
  validate :valid_category

  # callbacks

  # By default we set the publication status
  # to false if no other status is provided
  before_create do |item|
    if item.is_published.nil?
      item.is_published = false
    end
  end

  # Limitation of size for the description
  before_save do |item|
    if item.description && item.description.length > 500
      item.description = item.description[0..500]
    end
  end

  # enumerations
  ALMOST_NEW = "sin estrenar"
  USED       = "usado"
  OLD        = "deteriorado"

  def self.valid_status
    [ALMOST_NEW,
     USED,
     OLD].freeze
  end

  def self.categories
    ["electrónica",
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

  def published?
    is_published
  end

  # validation functions

  def price_is_positive
    if(price.nil? || price < 0)
      errors.add(:price, "El precio no puede ser negativo")
    end
  end

  def valid_status
    unless Item.valid_status.detect(status)
      errors.add(:status, "El estado del artículo no es válido")
    end
  end

  def valid_category
    unless Item.categories.detect(category)
      errors.add(:status, "La categoría del artículo no es válida")
    end
  end

end
