# Confirmation function
function read_confirm
  while true
    read -l -P "$argv? (y/N) " yn
    switch $yn
      case Y y; return 0
      case '' N n; return 1
    end
  end
end

# Show US flag
function attache_flag
  echo -en "\e[s"; tput cup 0 (tput cols); echo -n "🇺🇸"; echo -en "\e[u"
end

# Update menu.sh from GitHub
function attache_update_menu
  curl -sfL https://raw.githubusercontent.com/richknowles/attache/main/attache/menu.sh \
    > ~/.dotfiles/attache/menu.sh
  chmod +x ~/.dotfiles/attache/menu.sh
end

# Stubbed action functions (expand later)
function attache_plusx; echo "Plus-X placeholder"; end
function attache_colors; echo "Colors placeholder"; end
function attache_godmode; echo "GodMode placeholder"; end
function attache_news; curl -s https://redacted.inc/news-by-the-numbers/ | sed -n '1,5p' | nl -ba; end
function attache_speedtest; speedtest-cli; end
function attache_caddy; echo "Caddyshack placeholder"; end
function attache_tmux_menu; echo "Tmux submenu placeholder"; end
function attache_update_system
  and read_confirm "Update system"
  and begin
    if test -f /etc/debian_version; sudo apt update; sudo apt upgrade -y
    else if test -f /etc/fedora-release; sudo dnf upgrade -y
    else if test -f /etc/arch-release; sudo pacman -Syu --noconfirm
    end
  end
end

# Startup script actions
attache_flag
attache_update_menu
source ~/.dotfiles/attache/menu.sh
curl -s wttr.in?format=3
