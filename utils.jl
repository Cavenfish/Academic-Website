using TOML, FranklinUtils

const ROOT = Franklin.FOLDER_PATH[]
const CONF = TOML.parsefile("./config.toml")

include("./utils/cover.jl")
include("./utils/sidebar.jl")
include("./utils/showcase.jl")
include("./utils/cards.jl")
include("./utils/nav.jl")
include("./utils/software.jl")
include("./utils/posts.jl")

hfun_author_name() = CONF["general"]["author"]
hfun_author_bio() = CONF["general"]["my_bio"]
hfun_author_pronouns() = CONF["general"]["pronouns"]

function hfun_pronouns_heading()
  "<p class=\"pronouns\"> 
    $(CONF["general"]["pronouns"])
  </p>"
end

function hfun_short_bio()
  "<p class=\"short-bio\"> 
    $(CONF["general"]["my_bio"])
  </p>"
end