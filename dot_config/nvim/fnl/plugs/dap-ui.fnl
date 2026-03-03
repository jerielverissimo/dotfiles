[{1 :rcarriga/nvim-dap-ui
    :dependencies [:mfussenegger/nvim-dap
                   :nvim-neotest/nvim-nio]
    :config
  (fn []
    (let [d (require :dapui)]
      (d.setup {})))}]
