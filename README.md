# Teste Solfacil - Update Partners

## Docker
`docker compose up` to start server with loggs or `docker compose up -d` with no loggs.

## Release
Start release server with `mix release` and after `.\server`.

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

### Routes

we have four routes in our application

```elixir
scope "/api", SolfacilUpdatePartnersWeb do
    pipe_through :api

    post "/partner", PartnersController, :create

    get "/partner/:id", PartnersController, :list
end
```

The first route you can register your csv parterns list,

The second route you can get all your registered partners with your "dummy" id (so that a client doesn't get data from other clients)",

### POST params

```json
{
  "filename":"partners_path.csv",
  "client_id":"2451549900013822061991"
}
```

## Mailbox
access http://localhost:4000/dev/mailbox/ to see your sent mails.
