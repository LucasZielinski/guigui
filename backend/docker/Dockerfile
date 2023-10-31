FROM elixir:1.15

WORKDIR /app

# Installer Hex et Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copiez d'abord le projet
COPY . .

# Ensuite, installez les dépendances et compilez
RUN mix do deps.get, deps.compile

CMD ["mix", "phx.server"]
