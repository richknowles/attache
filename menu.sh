#!/usr/bin/env fish
function read_confirm
  while true
    read -l -P "$argv (y/N)? " yn
    switch $yn
      case Y y; return 0
      case '' N n; return 1
    end
  end
end

function attache_start
  echo "🎛️ Attache Menu"
  echo "1) Fish Only"
  echo "2) Fish + X"
  echo "3) GF Mode (sudo)"
  echo "4) Colors"
  echo "5) GodMode"
  echo "6) News"
  echo "7) Speedtest"
  echo "8) Chaos"
  echo "9) Future"
  echo "A) SSHD Mods (sudo)"
  echo "B) Star Wars ASCII"
  echo "C) Caddyshack Quotes"
  echo "M) Play Moan"
  echo "F) Show Flag"
  echo "T) Tmux Menu"
  echo "U) Update System (sudo)"
  echo "S) Edit sudoers (sudo)"
  echo "R) Uninstall Attache (sudo)"
  read -l ch
  switch $ch
    case 1; echo "🐟 Fish only (no-op)"
    case 2; attache_plusx
    case 3
      if read_confirm "Activate GF Mode"; then
        bash ~/.dotfiles/attache/gfmode.sh | lolcat
        sudo mpg123 ~/sounds/moan.mp3
      end
    case 4; attache_colors
    case 5; attache_godmode
    case 6; attache_news
    case 7; attache_speedtest
    case 8
      if read_confirm "Enter Chaos Mode"; then
        attache_news; attache_colors
        sudo fish -c attache_speedtest
      end
    case 9; echo "▶️ Future placeholder"
    case A
      if read_confirm "Apply SSHD mods"; then
        sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
        sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
        sudo systemctl restart sshd
      end
    case B
      echo "🌌 Starting Star Wars ASCII..."
      if telnet towel.blinkenlights.nl 2>&1 | grep -q Connected; then
        telnet towel.blinkenlights.nl
      else
        ssh starwarstel.net || echo "❌ Both Star Wars streams unavailable"
      end
    case C; attache_caddy
    case M; mpg123 ~/sounds/moan.mp3
    case F; attache_flag
    case T; attache_tmux_menu
    case U; attache_update_system
    case S
      if read_confirm "Edit sudoers"; then
        sudoedit /etc/sudoers
      end
    case R
      if read_confirm "Uninstall Attache"; then
        stow -D fish attache -t $HOME
        sudo rm -rf ~/.dotfiles
        exec fish
      end
    case '*'; echo "❌ Invalid"
  end
end

attache_start
