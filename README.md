# QueroApi

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

docker build -t quero_api --build-arg DATABASE_URL=postgres://postgres:postgres@10.0.1.109:5432/quero_api --build-arg SECRET_KEY_BASE=sJlfQuGFNlJqGDLmuIjwUjMSOAZAPTZEUJqhVjITg052bxB51s7aa1M7mR+4DCZ+ .

docker run quero_api mix ecto.setup
