defmodule SolfacilUpdatePartners.Partner.SendEmail do
  import Swoosh.Email
  require Logger

  alias SolfacilUpdatePartners.Mailer


  # SolfacilUpdatePartners.Partner.SendEmail.test

  def test do
    %{
      "cep" => " 29090490",
      "cidade" => "Vitória",
      "client_id" => "2451549900013822061991",
      "cnpj" => "02.558.157/0001-62",
      "email" => " vivo@vivo",
      "estado" => "ES",
      "nome_fantasia" => " VIVO",
      "razao_social" => " Vivo LTDA",
      "telefone" => " 555555555"
    }
    |> check_email()
  end

  def check_email(partner) do
    # IO.inspect(partner, label: "XXXXXXXXXX NOVO CONTATO - ENVIANDO EMAIL XXXXXXXXXX")
    # /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    if String.match?(partner["email"], ~r/@/) do
      Logger.info("Email de boas vindas enviado para #{partner["email"]}")
      send(partner)
      # send(partner)
    else
      Logger.info("Não foi possível enviar um email de boas vindas.")
    end
  end

  # SolfacilUpdatePartners.Partner.SendEmail.send
  def new_email(partner) do
    new()
    |> to({"#{partner["razao_social"]}", "williamjager.dev@gmail.com"})
    |> from({"William Jäger", "williamjager.dev@gmail.com"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Welcome #{partner["razao_social"]}</h1>")
    |> text_body("Welcome to my partners save system #{partner["razao_social"]}.\n")
  end

  def send(partner) do
    new_email(partner)
    |> Mailer.deliver()
  end


end
