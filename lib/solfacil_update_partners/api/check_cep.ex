defmodule SolfacilUpdatePartners.Api.CheckCep do
  require Logger

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
    case cep do
      nil -> {:error, "Invalid CEP"}
      cep ->
        cep = Regex.replace(~r/\D/, cep, "")
        HTTPoison.get("viacep.com.br/ws/" <> cep <> "/json") |> handle_response(cep)
    end
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, _cep) do
    result = Jason.decode(body)

    case result do
      {:ok, %{"erro" => true}} ->
        {:error, "Invalid CEP"}

      {:ok, result} ->
        {:ok, result}
    end
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: _status_code}}, cep) do
    Logger.info("Nenhum dado foi encontado para este o cep #{cep}.")
    {:error, "Invalid CEP"}
  end
end
