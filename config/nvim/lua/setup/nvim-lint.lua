require "nvim-lint".setup {
   require("lint").linters_by_ft = {
      clojure = {"clj-kondo"},
    }
}
