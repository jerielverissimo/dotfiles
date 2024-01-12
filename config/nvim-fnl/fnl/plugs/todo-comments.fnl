[{1 :folke/todo-comments.nvim
  :dependencies [:nvim-lua/plenary.nvim]
  :config
  (fn []
    (let [todo (require :todo-comments)]
      (todo.setup {})))}]
