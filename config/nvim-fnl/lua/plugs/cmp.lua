local _local_1_ = require("core.module")
local autoload = _local_1_["autoload"]
local cmp = autoload("cmp")
local luasnip = autoload("luasnip")
local shared = require("core.lib.shared")
local cmp_src_menu_items = {buffer = "buff", conjure = "conj", nvim_lsp = "lsp", vsnip = "vsnp", luasnip = "lsnp"}
local cmp_srcs = {{name = "nvim_lsp"}, {name = "conjure"}, {name = "buffer"}, {name = "vsnip"}, {name = "luasnip"}}
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return ((col ~= 0) and (vim.api.nvim_buf_get_lines(0, (line - 1), line, true)[1]:sub(col, col):match("%s") == nil))
end
local function _2_()
  do
    local cmp0 = require("cmp")
    local luasnip0 = require("luasnip")
    local function _3_(args)
      return luasnip0.lsp_expand(args.body)
    end
    local function _4_(entry, item)
      item.menu = (cmp_src_menu_items[entry.source.name] or "")
      item.kind = shared.codicons[item.kind]
      return item
    end
    local function _5_(fallback)
      if cmp0.visible() then
        return cmp0.select_next_item()
      elseif luasnip0.expand_or_jumpable() then
        return luasnip0.expand_or_jump()
      elseif has_words_before() then
        return cmp0.complete()
      elseif "else" then
        return fallback()
      else
        return nil
      end
    end
    local function _7_(fallback)
      if cmp0.visible() then
        return cmp0.select_prev_item()
      elseif luasnip0.jumpable(-1) then
        return luasnip0.jump(-1)
      elseif "else" then
        return fallback()
      else
        return nil
      end
    end
    cmp0.setup({experimental = {ghost_text = true}, view = {entries = {name = "custom", selection_order = "near_cursor"}}, preselect = cmp0.PreselectMode.None, snippet = {expand = _3_}, formatting = {fields = {"kind", "abbr", "menu"}, format = _4_}, mapping = {["<C-p>"] = cmp0.mapping.select_prev_item(), ["<C-n>"] = cmp0.mapping.select_next_item(), ["<C-b>"] = cmp0.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp0.mapping.scroll_docs(4), ["<C-Space>"] = cmp0.mapping.complete(), ["<C-e>"] = cmp0.mapping.close(), ["<CR>"] = cmp0.mapping.confirm({behavior = cmp0.ConfirmBehavior.Insert, select = true}), ["<Tab>"] = cmp0.mapping(_5_, {"i", "s"}), ["<S-Tab>"] = cmp0.mapping(_7_, {"i", "s"})}, sources = cmp_srcs})
  end
  cmp.setup.cmdline("/", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer", group_index = 1}}})
  return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "path"}, {name = "cmdline", group_index = 1}}})
end
return {{"hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-vsnip", "hrsh7th/cmp-path", "PaterJason/cmp-conjure", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "onsails/lspkind.nvim", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp-signature-help"}, config = _2_}}