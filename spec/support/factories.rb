module Factories

  def factory_create(factory_name)
    obj = self.send(factory_name)
    obj.save!
    obj.reload
    obj
  end

  def factory_build(factory_name)
    obj = self.send(factory_name)
    obj
  end

  def with_authenticated_user
    user = factory_create :valid_user
    controller.session[:user_token] = user.token
    yield user
  end

  # Users
  def valid_user
    User.new(:nick  => 'john',
             :email => 'john@island.org',
             :token => 'valid_token')
  end

  # Sales
  def valid_unlimited_sale
    Sale.new(:is_unlimited => true,
             :province     => 'Barcelona',
             :zip_code     => '8305',
             :latitude     => 2.42423432542,
             :longitude    => -1.3423424)
  end
end
