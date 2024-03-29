using TOML, FranklinUtils

const ROOT = Franklin.FOLDER_PATH[]

function hfun_navigation()
  io  = IOBuffer()
  dir = joinpath(ROOT, "pages")

  for i in walkdir(dir)
    if !(isempty(i[3]))
      for page in i[3]
        tmp = split(page, '.')[1]
        ref = joinpath("pages", tmp)
        nam = pagevar(ref, "name")
        write(io, "<li><a href=\"/$(ref)\">$(nam)</a></li>\n")
      end
    end
  end

  take!(io) |> String
end

@lx function br(; n=1)
  repeat("<br>", n)  |> html
end

@lx function coverButton(; ref="", txt="")
  html("""<a href="$(ref)" class="cover-button">$(txt)</a>""")
end

@env function coverBody(md; class="")
  html("""
  <div class="cover-body">""") * md * html("""
  </div>
  """)
end

@lx function coverLinks(; id="")
  io = IOBuffer()
  links = globvar("links")

  write(io, "<ul>")
  for link in links
    write(io, """
    <li>
    <a href="$(link[1])" target=_blank>
      <i class="$(link[2]) fa-2x" aria-hidden="true"></i>
    </a></li>
    """)
  end
  write(io, "</ul>")

  take!(io) |> String |> html
end

@lx function showcase(; ref="", byyear=false)

  file = joinpath(ROOT, "_assets", "items", ref)

  toml = TOML.parsefile(file)

  items = [i[2] for i in toml] |> (x -> sort(x, by=(e->e["date"]), rev=true))

  isempty(items) && return ""

  io      = IOBuffer()
  curyear = year(items[1]["date"])

  byyear && write(io, "~~~\n<h2>$(curyear)</h2>\n~~~\n")

  for item in items
    if byyear && year(item["date"]) < curyear
      curyear = year(item["date"])
      write(io, "~~~\n<h2>$(curyear)</h2>\n~~~\n")
    end

    title  = item["title"]
    date   = item["date"]
    bullet = "~~~<p>"

    haskey(item, "url") ?
    bullet *= "<a href=\"$(item["url"])\"> $(title) </a><br>" :
    bullet *= "$(title)<br>"

    haskey(item, "authors") ? 
    bullet *= "<small>$(item["authors"])</small><br>" : nothing

    haskey(item, "venue") ? 
    bullet *= "<small><i>$(item["venue"])</i></small>" : nothing

    haskey(item, "journal") ? 
    bullet *= "<small><i>$(item["journal"])</i></small>" : nothing

    haskey(item, "url") ? url = item["url"] : url = ""

    bullet *= "</p>~~~"

    write(io, "- $(bullet)\n")
  end

  take!(io) |> String 
end