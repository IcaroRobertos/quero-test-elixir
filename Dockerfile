# Use an official Elixir runtime as a parent image
FROM elixir:latest

# Define vars
ARG DATABASE_URL
ARG SECRET_KEY_BASE
ARG SEED

# Define environment
ENV DATABASE_URL=${DATABASE_URL}
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
ENV MIX_ENV=prod

RUN echo ${DATABASE_URL}

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force && mix local.rebar --force

# Compile the project
RUN MIX_ENV=prod mix compile

# Install phoenix framework
RUN mix archive.install hex phx_new 1.5.7

# Start application
CMD [ "mix", "phx.server" ]

EXPOSE 4000