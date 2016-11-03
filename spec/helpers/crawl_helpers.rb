# HTML in strings - on the given domain
def html_single_link
  '<a href="/link">a link</a>'
end
def html_single_link_multidir
  '<a href="/link/in/another/folder">a link</a>'
end
def html_single_link_file
  '<a href="/link.html">a link</a>'
end
def html_single_internal_domain_link
  '<a href="http://ormi.io/link"'
end
def html_single_img
  '<img src="/img/image.png">'
end

# HTML external

def html_external_link
  '<a href="http://www.external-link.com">a link</a>'
end
