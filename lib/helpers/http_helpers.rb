def strip_http(url)
  url.sub(/^https?\:\/\/?/,'')
end

def prepend_http(url)
    url = "http://#{url}" unless url=~/^https?:\/\//
end
