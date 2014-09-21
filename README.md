tmux-do
-----

**김젼**이 서버를 껐다 켤때마다 실행하는 tmux 명령어를 자동으로 실행해주는 스크립트.

### How to use

1.  Create sessions

    ```
    git clone https://github.com/simnalamburt/tmux-do.git ~/.tmux-do
    cd ~/.tmux-do
    ruby init.rb
    ```

2.  Add the helper directory to `PATH`

    ```
    export PATH="$HOME/.tmux-do/bin:$PATH"
    ```

### Requirements

* **tmux**
* ruby
