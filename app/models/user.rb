class User < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :nick
  validates_presence_of :token
  validates_uniqueness_of :email
  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => 'el email debe ser v&aacute;lido'
end
