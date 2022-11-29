defmodule SolfacilUpdatePartners.Partner.Csv do
  @doc """
  Esta função recebe um arquivo .csv e o decoda.

  ## Examples

    iex> SolfacilUpdatePartners.Partner.Csv.get_csv(
    iex(1)>   %Plug.Upload{
    iex(2)>      path: "c:/Users/willi/AppData/Local/Temp/plug-1669/multipart-1669683066-660327771013-3",
    iex(3)>      content_type: "text/csv",
    iex(4)>      filename: "partners.csv"
    iex(5)>    }
    iex(6)>  )

    #Stream<[
      enum: #Function<61.124013645/2 in Stream.transform/4>,
      funs: [#Function<48.124013645/1 in Stream.map/2>]
    ]>

  """
  def get_csv(file) do
    "#{file.path}"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode(headers: true)
  end
end
