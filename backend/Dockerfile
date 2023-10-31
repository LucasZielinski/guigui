FROM elixir:latest

WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force 

COPY mix.exs mix.lock ./

RUN mix deps.get

COPY . .

RUN mix ecto.create

RUN mix ecto.migrate

# EXPOSE 4000

CMD ["mix", "phx.server"]
