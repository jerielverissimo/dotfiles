-- [nfnl] fnl/plugs/cmp.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local cmp = autoload("cmp")
local shared = require("core.lib.shared")
local cmp_src_menu_items = {buffer = "buff", conjure = "conj", nvim_lsp = "lsp", vsnip = "vsnp", luasnip = "lsnp"}
local cmp_srcs = {{name = "nvim_lsp"}, {name = "conjure"}, {name = "buffer"}, {name = "vsnip"}, {name = "luasnip"}}
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return ((col ~= 0) and (((vim.api.nvim_buf_get_lines(0, (line - 1), line, true))[1]):sub(col, col):match("%s") == nil))
end
local function _2_()
  do
    local luasnip = require("luasnip")
    local function _3_(entry, item)
      item.menu = (cmp_src_menu_items[entry.source.name] or "")
      item.kind = shared.codicons[item.kind]
      return item
    end
    local function _4_(fallback)
      if cmp.visible() then
        return cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        return luasnip.expand_or_jump()
      elseif has_words_before() then
        return cmp.complete()
      elseif "else" then
        return fallback()
      else
        return nil
      end
    end
    local function _6_(fallback)
      if cmp.visible() then
        return cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        return luasnip.jump(-1)
      elseif "else" then
        return fallback()
      else
        return nil
      end
    end
    local function _8_(args)
      return luasnip.lsp_expand(args.body)
    end
    cmp.setup({experimental = {ghost_text = true}, view = {entries = {name = "custom", selection_order = "near_cursor"}}, preselect = cmp.PreselectMode.None, formatting = {fields = {"kind", "abbr", "menu"}, format = _3_}, mapping = {["<C-p>"] = cmp.mapping.select_prev_item(), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.close(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}), ["<Tab>"] = cmp.mapping(_4_, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(_6_, {"i", "s"})}, snippet = {expand = _8_}, sources = cmp_srcs})
  end
  cmp.setup.cmdline("/", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer", group_index = 1}}})
  return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "path"}, {name = "cmdline", group_index = 1}}})
end
return {{dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-vsnip", "hrsh7th/cmp-path", "PaterJason/cmp-conjure", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "onsails/lspkind.nvim", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp-signature-help"}, config = _2_, "hrsh7th/nvim-cmp"}}
