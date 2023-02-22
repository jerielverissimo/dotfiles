(local dap (require :dap))
(local dapui (require :dapui))

(set dap.adapters.codelldb
     {:type :server
      :port "${port}"
      :executable {:command :codelldb :args [:--port "${port}"]}})

(local lldb-configs
       [{:name "lldb: Launch (console)"
         :type :codelldb
         :request :launch
         :program (fn []
                    (vim.fn.input "Path to executable: "
                                  (.. (vim.fn.getcwd) "/") :file))
         :cwd "${workspaceFolder}"
         :stopOnEntry true}
        {:name "lldb: Launch (integratedTerminal)"
         :type :codelldb
         :request :launch
         :program (fn []
                    (vim.fn.input "Path to executable: "
                                  (.. (vim.fn.getcwd) "/") :file))}])

(set dap.configurations.c lldb-configs)
(set dap.configurations.c dap.configurations.cpp)

(set dap.configurations.rust lldb-configs)

(set dap.configurations.lua
     [{:type :nlua :request :attach :name "Attach to running Neovim instance"}])

(set dap.adapters.nlua
     (fn [callback config]
       (callback {:type :server
                  :host (or config.host :127.0.0.1)
                  :port (or config.port 8086)})))

(dapui.setup {:icons {:expanded "" :collapsed "" :current_frame ""}
              :controls {:icons {:pause ""
                                 :play "契"
                                 :step_into ""
                                 :step_over ""
                                 :step_out ""
                                 :step_back ""
                                 :run_last ""
                                 :terminate ""}}
              :floating {:border :single}})
