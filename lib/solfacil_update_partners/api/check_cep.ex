defmodule SolfacilUpdatePartners.Api.CheckCep do
  def get_address(cep) do
    cep = cep |> String.replace([",", "-", ".", "_"], "")
    HTTPoison.get("viacep.com.br/ws/" <> cep <> "/json") |> handle_response()
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Jason.decode(body)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, %{status_code: status_code}}
  end
end
