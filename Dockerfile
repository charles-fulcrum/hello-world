FROM ubuntu:20.04

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Setup shell
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Install needed packages
RUN apt update
RUN apt install -y vim curl wget tmux git

# Setup .vimrc
RUN echo -e \
  'set number\n' \
  'set relativenumber\n' \
  'set clipboard=unnamedplus\n' \
  'set ignorecase\n' \
  '\n' \
  'imap jk <esc>\n' \
  'noremap J 10j\n' \
  'noremap K 10k\n' \
  'noremap H ^\n' \
  'noremap L $\n' \
  'nnoremap U <c-r>\n' \
  'xnoremap p pgvy\n' \
  > /root/.vimrc

# Add Ctrl+Backspace in terminal
RUN echo '"\C-H": shell-backward-kill-word' >> /etc/inputrc

# Setup neovim
RUN apt install -y build-essential
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
RUN dpkg -i nvim-linux64.deb
RUN rm nvim-linux64.deb
RUN git clone https://github.com/esfox/nvim /root/.config/nvim

WORKDIR /root

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Setup git
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RUN git config --global user.email charles@nyfulcrum.com
RUN git config --global user.name charles-fulcrum

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Setup .NET
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Download Microsoft signing key and repository
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

# Install Microsoft signing key and repository
RUN dpkg -i packages-microsoft-prod.deb

# Clean up
RUN rm packages-microsoft-prod.deb

# Update packages
RUN apt update

# Install dotnet-sdk-3.1
ENV TZ=Asia/Manila
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install -y dotnet-sdk-3.1

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Setup Node.js
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Setup fnm
RUN curl -fsSL https://fnm.vercel.app/install | bash
RUN source /root/.bashrc
RUN fnm install --lts
RUN fnm use default

# Install and setup PNPM
RUN npm i -g pnpm
ENV PNPM_HOME=/root/.pnpm
ENV PATH="${PNPM_HOME}:${PATH}"

RUN pnpm i -g @angular/cli

