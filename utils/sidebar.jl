
function add_link(io, link, icon)
  write(
    io, 
    """
    <li>
      <a href=\"$(link)\" target=_blank>
        <i class=\"$(icon)\" aria-hidden=\"true\"></i>
      </a>
    </li>
    """
  )
end

function hfun_sidebar_links()
  links  = CONF["links"] |> values |> collect
  n      = length(links)
  io     = IOBuffer()
  nrows  = n / 5 |> ceil
  nshort = n % 5

  for i = 1:nshort
    link, icon = links[i]
    add_link(io, link, icon)
  end

  write(io, "<br><br>\n")

  i = 0
  for (link, icon) in links[nshort+1:end]
    if i == 5
      write(io, "<br><br>\n")
      i = 0
    end

    add_link(io, link, icon)

    i += 1
  end

  take!(io) |> String
end
