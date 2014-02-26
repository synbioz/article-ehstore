module ProductsHelper
  def show_properties(hash)
    return nil if hash.nil? || hash.empty?

    content_tag :span, class: 'properties' do
      hash.each do |key, val|
        prop = content_tag(:span, class: 'property') do
          concat content_tag(:span, key, class: 'key')
          concat content_tag(:span, val, class: 'val')
        end
        concat prop
      end
    end
  end
end
