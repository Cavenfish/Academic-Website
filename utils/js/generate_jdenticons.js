const fs = require("fs");
const toml = require("smol-toml");
const jdenticon = require("jdenticon");

function find_missing_pics(team) {
  const keys = Object.keys(team);
  let ret = [];

  for (let i = 0; i < keys.length; i++) {
    if (keys[i] == "order") {
      continue;
    }

    let tmp = team[keys[i]];

    if (!("image" in tmp)) {
      ret.push(keys[i]);
    }
  }

  return ret;
}

function generate_jdenticons(name) {
  const sav = "./_assets/figs/" + name + ".png";
  const png = jdenticon.toPng(name, 200);
  fs.writeFileSync(sav, png);
}

function fill_toml(data, names) {
  for (let i = 0; i < names.length; i++) {
    data.team[names[i]].image = "/assets/figs/" + names[i] + ".png";
  }

  const toml_string = toml.stringify(data);

  fs.writeFileSync("./config.toml", toml_string);
}

function main() {
  const file = fs.readFileSync("./config.toml", "utf8");
  const data = toml.parse(file);
  const miss = find_missing_pics(data.team);

  miss.map(generate_jdenticons);

  fill_toml(data, miss);
}

main();
