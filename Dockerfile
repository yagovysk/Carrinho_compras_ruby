# Use a imagem base do Ubuntu 20.04 (focal)
FROM phusion/passenger-full:2.2.0

# Defina variáveis de ambiente
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

# Remova serviços desnecessários do Phusion Passenger
RUN rm -f /etc/service/nginx/down && \
    rm -f /etc/service/sshd/down

# Instale dependências do sistema
RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libreadline-dev \
        libyaml-dev \
        libxml2-dev \
        libxslt-dev \
        libffi-dev \
        libgdbm-dev \
        libncurses5-dev \
        autoconf \
        bison \
        libreadline6-dev \
        ruby-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instale o rbenv e ruby-build
RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT && \
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build && \
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && \
    chmod +x /etc/profile.d/rbenv.sh

# Configure o ambiente do rbenv
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh && \
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh && \
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

# Instale o Ruby 3.1.6 e defina como global
RUN /bin/bash -c "source /etc/profile.d/rbenv.sh && \
    rbenv install 3.1.6 && \
    rbenv global 3.1.6 && \
    rbenv rehash && \
    gem install bundler && \
    ruby -v"

# Defina o diretório de trabalho
WORKDIR /app

# Copie o código-fonte do projeto
COPY . /app

# Instale as dependências do projeto
RUN bundle install

# Adicione o arquivo de configuração do Nginx
COPY config/nginx.conf /etc/nginx/sites-enabled/depot.conf

# Expõe a porta 80 (HTTP)
EXPOSE 80

# Comando padrão para iniciar o Nginx e o Passenger
CMD ["/sbin/my_init"]
