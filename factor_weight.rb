class FactorWeight
  include DatabaseConnector
  attr_accessor :id, :site, :chloroform_weight, :bromoform_weight, :bromodichloromethane_weight, :dibromichloromethane_weight
end
