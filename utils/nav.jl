function hfun_navigation()
  io  = IOBuffer()
  dir = joinpath(ROOT, "pages")
  inf = walkdir(dir) |> take!

  isempty(inf[3]) && return take!(io) |> String

  for item in inf[3]
    page = split(item, ".")[1]
    ref  = joinpath("pages", page)
    name = pagevar(ref, "name")

    write(
      io, 
      """
      <li>
        <a href="/$(ref)">$(name)</a>
      </li>\n
      """
    )
  end

  for sub in inf[2]
    ind = joinpath(inf[1], sub, "index.md")

    if isfile(ind)
      ref  = joinpath("pages", sub)
      tmp  = joinpath(ref, "index")
      name = pagevar(tmp, "name")

      write(
        io, 
        """
        <li>
          <a href="/$(ref)">$(name)</a>
        </li>\n
        """
      )
    end
  end
  
  take!(io) |> String
end