defmodule SolfacilUpdatePartners.Partner.SendEmail do
  import Swoosh.Email
  require Logger

  alias SolfacilUpdatePartners.Mailer

  @doc """
  Função responsável por receber os dados de um parceiro e se houver um email válido, notificar o salvamento deste parceiro por email..
  
  ## Examples
  
    iex> SolfacilUpdatePartners.Partner.SendEmail.check_email(%{
    iex(1)>  "cep" => " 29090490",
    iex(2)>  "cidade" => "Vitória",
    iex(3)>  "client_id" => "2451549900013822061991",
    iex(4)>  "cnpj" => "02.558.157/0001-62",
    iex(5)>  "email" => " vivo@vivo",
    iex(6)>  "estado" => "ES",
    iex(7)>  "nome_fantasia" => " VIVO",
    iex(8)>  "razao_social" => " Vivo LTDA",
    iex(9)>  "telefone" => " 555555555"
    iex(10)>   })
  
    [info] [email_id: "d286f5ee157407baa876f2c15a22e6bb", msg: "Um email de boas vindas foi enviado para  vivo@vivo", partner_cnpj: "02.558.157/0001-62", status: "Email enviado"]
  
  
  
  """

  def check_email(partner) do
    if String.match?(partner["email"], ~r/@/) do
      send(partner)
    else
      msg = %{
        partner_cnpj: partner["cnpj"],
        status: "Email não enviadoenviado",
        msg: "Não foi possível enviar um email de boas vindas."
      }

      Logger.info(msg)
      msg
    end
  end

  defp send(partner) do
    new_email(partner)
    |> Mailer.deliver()
    |> handle_send(partner)
  end

  defp handle_send({:ok, _return}, partner) do
    msg = %{
      partner_cnpj: partner["cnpj"],
      status: "Email enviado",
      msg: "Um email de boas vindas foi enviado para #{partner["email"]}"
    }

    Logger.info(msg)

    msg
  end

  defp handle_send({:error, error}, partner) do
    msg = %{
      partner_cnpj: partner["cnpj"],
      status: "Email enviado",
      msg: "Um email de boas vindas foi enviado para #{partner["email"]}",
      error: error
    }

    Logger.info(msg)

    msg
  end

  defp new_email(partner) do
    new()
    |> to({"#{partner["razao_social"]}", "williamjager.dev@gmail.com"})
    |> from({"William Jäger", "williamjager.dev@gmail.com"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Welcome #{partner["razao_social"]}</h1>")
    |> text_body("Welcome to my partners save system #{partner["razao_social"]}.\n")
  end
end
