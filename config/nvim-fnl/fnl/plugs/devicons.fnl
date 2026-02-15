(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :nvim-tree/nvim-web-devicons
    :branch "master"
    :event "BufRead"
    :lazy true
    :config (fn []
              (let [devicons (require :nvim-web-devicons)
                    config {:default true
                     :override {:Dockerfile {:icon "" :name :Dockerfile}
                     :astro {:icon "󰑣" :name :SVELTE}
                     :c {:icon "" :name :C}
                     :css {:icon "" :name :CSS}
                     :deb {:icon "" :name :Deb}
                     :html {:icon "" :name :HTML}
                     :jpeg {:icon " " :name :JPEG}
                     :jpg {:icon " " :name :JPG}
                     :js {:icon " " :name :JS}
                     :kt {:icon "" :name :Kt}
                     :lock {:icon "󰌾" :name :Lock}
                     :md {:icon ""}
                     :mp3 {:icon "󰎈" :name :MP3}
                     :mp4 {:icon "" :name :MP4}
                     :out {:icon "" :name :Out}
                     :png {:icon "" :name :PNG}
                     :py {:icon "" :name :Py}
                     :rb {:icon "󰴭"}
                     :robots.txt {:icon "󱚣" :name :robots}
                     :rpm {:icon "" :name :RPM}
                     :rust {:icon "󱘗" :name :Rust}
                     :toml {:icon "" :name :TOML}
                     :ts {:icon "󰛦" :name :TS}
                     :ttf {:icon "" :name :TrueTypeFont}
                     :vim {:icon "" :name :Vim}
                     :vue {:icon "󰡄" :name :Vue}
                     :woff {:icon "" :name :WebOpenFontFormat}
                     :woff2 {:icon "" :name :WebOpenFontFormat2}
                     :xz {:icon "" :name :XZ}
                     :yuck {:icon "󰇷" :name :Yuck}
                     :zip {:icon "" :name :Zip}}}] 
                (devicons.set_default_icon "󰈚")
                (devicons.setup config)))}]
