
function hfun_author_img()
  gen = CONF["general"]

  "<img src=\"$(gen["my_picture"])\" alt=\"$(gen["author"])\">"
end

function hfun_cover()
  style = locvar("style")
  file  = "./_layout/cover/$(style).html" 
  
  read(file, String) |> Franklin.convert_html
end

function hfun_cover_links()
  io    = IOBuffer()
  links = CONF["links"]

  write(io, "<ul>")
  for link in values(links)
    write(io, """
    <li>
    <a href="$(link[1])" target=_blank>
      <i class="$(link[2]) fa-2x" aria-hidden="true"></i>
    </a></li>
    """)
  end
  write(io, "</ul>")

  take!(io) |> String
end