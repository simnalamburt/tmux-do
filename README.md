tmux-do
-----

**김젼**이 서버를 껐다 켤때마다 실행하는 tmux 명령어를 자동으로 실행해주는 스크립트.

### How to use

* Option 1. Run the script directly from Github

  ```
  # with cURL
  \curl -sSL https://bit.ly/1j6q2vU | ruby

  # with Wget
  wget -qO - https://bit.ly/1j6q2vU | ruby
  ```

* Option 2. Save the script into your server

  ```
  git clone https://github.com/simnalamburt/tmux-do.git
  cd tmux-do
  ./irc

  # or link it to your $PATH dir
  ln -s $(pwd)/irc ~/.local/bin/
  irc
  ```

### Requirements

* **tmux**
* ruby
