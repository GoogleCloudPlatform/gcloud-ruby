def javascripts_full_list
  # Remove jquery as we already load jquery in the site.
  super - ["js/jquery.js"]
end
