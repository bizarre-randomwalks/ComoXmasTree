xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.categories do
  @categories.each do |category|
    xml.category do 
      xml.id(category.id)
      xml.title(category.title)
      xml.huemin(category.huemin)
      xml.huemax(category.huemax)
    end
  end
end
