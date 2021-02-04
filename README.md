# QueroApi

This is a application to show and filter courses offers by [Quero Bolsa](https://querobolsa.com.br/).

To run this project, you need have [Elixir](https://elixir-lang.org/install.html) and [Phoenix Framework](https://hexdocs.pm/phoenix/installation.html#phoenix) installed in your machine.

# Third party

The QueroApi uses Postgres database.
To start easyly, use docker-compose with:

```
docker-compose up -d
```

The above command will up the follow containers:

- `postgres` on port `5432`
- `adminer` on port `8080`

# Dependencies

To install dependencies:

```
mix deps.get
```

# Database config

To setup your database, use:

```
mix ecto.setup
```

or individually:

- To create repo:

```
mix ecto.create
```

- To create tables:

```
mix ecto.migrate
```

- To populate tables:

```
run priv/repo/seeds.exs
```

if you need restart database, use:

```
mix ecto.reset
```

# Tests

To run tests, use:

```
mix test --trace
```

# Run application

To run the application, use:

```
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Run with docker in production environment

To run the application with docker, follow the bellow steps:

- Build docker image

```
docker build -t quero_api --build-arg DATABASE_URL={YOUR_DATABASE_URL} --build-arg SECRET_KEY_BASE={YOUR_SECRET_KEY} .
```

- Config production database

```
docker run quero_api mix ecto.setup
```

- Run docker image

```
docker run -d -p 80:4000 quero_api
```

Now you can visit [`localhost:80`](http://localhost:80) from your browser.

# Demo Application

You can visit a demonstration on [http://34.234.217.126](http://34.234.217.126)
