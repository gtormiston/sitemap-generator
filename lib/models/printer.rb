def print_sitemap_html(data)
  @html = ''
  i = 0
  count = data.count
  while i < count do
    data.each do |link|
      @html << "<div class='row'>"
      @html << "<div class='col-sm-6'>"
      @html << "<p>" + i.to_s + "</p>" + "<h3 class='pull-right'>" + link[0].to_s + "</h3></div>"
      @html << "<ul class='col-sm-6'>"
      link[3].each { |x| @html << ("<li>" + x.to_s + "</li>") }
      @html << "</ul></div>"
      i+=1
    end
  end
  return @html
end

  # def print_xml
  #   # TODO
  # end
