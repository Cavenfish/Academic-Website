
@lx function software(title, blurb; repo=nothing, docs=nothing)
  io = IOBuffer()

  repo_link = if repo != nothing
    """
    <a href="$(repo)" target=_blank>
      <i class="fa fa-brands fa-github" aria-hidden="true"></i>
    </a>
    """
  else
    ""
  end

  docs_link = if docs != nothing
    """
    <a href="$(docs)" target=_blank>
      <i class="fa fa-book" aria-hidden="true"></i>
    </a>
    """
  else
    ""
  end

  """
  <div class="software">
    <div class="title">
      <h1>$(title)</h1>
    </div>
    <div class="links">
      <ul>
        <li>
          $(repo_link)
        </li>
        <li>
          $(docs_link)
        </li>
      </ul>
    </div>
    <div class="blurb">
      <p>$(blurb)</p>
    </div>
  </div>
  """ |> html
end