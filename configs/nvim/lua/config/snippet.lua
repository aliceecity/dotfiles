local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

local ps = ls.parser.parse_snippet

ls.add_snippets(
  "java", {
    ps(
      "pc",
      "public class $1 {\n  public static void main(String[] args) {\n    $2\n  }\n}"
    ),
    ps(
      "main",
      "public static void main(String[] args) {\n\t$1\n}"
    ),
    ps(
      "sout",
      "System.out.println(\"$1\");"
    ),
    ps(
      "tc",
      "try {\n  $1\n} catch ($2 e){\n  $3\n}"
    ),
  }
)

ls.add_snippets(
  "c", {
    ps(
      "main",
      "int main(int argc, char** argv) {\n  $1\n}"
    ),
    ps(
      "sw",
      "switch($1){\n  case $2:\n    $3\n    break;\n}"
    ),
  }
)

ls.add_snippets(
  "rust", {
    ps(
      "mt",
      "match $1 {\n  $2 => $3,\n  _ => {}\n}"
    ),
    ps(
      "drv",
      "#[derive($1)]"
    ),
    ps(
      "disp",
      "impl Display for $1 {\n  fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {\n    $2\n  }\n}"
    ),
    ps(
      "std",
      "use std::{\n  $1,\n};"
    ),
  }
)
