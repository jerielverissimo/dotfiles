[{1 :editor-code-assistant/eca-nvim
    :dependencies [:MunifTanjim/nui.nvim
                   :nvim-lua/plenary.nvim]
    :config
    (fn []
      (let [eca (require :eca)]
        (eca.setup {})))}]
