defmodule SolfacilUpdatePartners.Partner.SendEmail do
  import Swoosh.Email
  require Logger

  # SolfacilUpdatePartners.Partner.SendEmail.send
  def send(partner) do
    new()
    |> to({"#{partner["razao_social"]}", "williamjager.dev@gmail.com"})
    |> from({"William Jäger", "williamjager.dev@gmail.com"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Welcome #{partner["razao_social"]}</h1>")
    |> text_body("Welcome to my partners save system #{partner["razao_social"]}.\n")
  end

  def check_email(partner) do
    # /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    if String.match?(partner["email"], ~r/@/) do
      Logger.info("Email de boas vindas enviado para #{partner["email"]}")
      # send(partner)
    else
      Logger.info("Não foi possível enviar um email de boas vindas.")
    end
  end
end
