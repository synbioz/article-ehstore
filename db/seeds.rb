PROPERTIES = {
  'color'    => %w(red green blue purple black white),
  'size'     => %w(6 6.25 6.50 6.75 7 7.25 7.50 7.75 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14),
  'gender'   => %w(male female),
  'category' => %w(sport city)
}

1000.times do |i|
  properties = PROPERTIES.each_with_object({}) { |(p, l), h| h[p] = l.sample }
  Product.create(title: "Product-#{i}", properties: properties)
end
