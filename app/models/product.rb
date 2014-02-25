class Product < ActiveRecord::Base
  serialize :properties, ActiveRecord::Coders::Hstore
end
