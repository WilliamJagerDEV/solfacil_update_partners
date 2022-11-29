defmodule SolfacilUpdatePartners.Api.CheckCep do
  @doc """
  Esta função envia um cep para a api X e recebe dados locais desde cep.

  ## Examples

      iex> SolfacilUpdatePartners.Api.CheckCep.get_address("29.164-815")
      {:ok,
        %{
          "bairro" => "Bicanga",
          "cep" => "29164-815",
          "complemento" => "",
          "ddd" => "27",
          "gia" => "",
          "ibge" => "3205002",
          "localidade" => "Serra",
          "logradouro" => "Rua Guanabara",
          "siafi" => "5699",
          "uf" => "ES"
        }}

  """

  def get_address(cep) do
    cep = Regex.replace(~r/\D/, cep, "")
    HTTPoison.get("viacep.com.br/ws/" <> cep <> "/json") |> handle_response()
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Jason.decode(body)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, %{status_code: status_code}}
  end

  # SolfacilUpdatePartners.Api.CheckCep.test("29.164-815")
  def test(cep) do
    cep |> String.replace([",", "-", ".", "_"], "")
  end
end
