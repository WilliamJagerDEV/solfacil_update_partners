defmodule SolfacilUpdatePartners.Partner.CsvTest do
  use ExUnit.Case
  doctest SolfacilUpdatePartners.Partner.Csv
  alias SolfacilUpdatePartners.Partner.Csv

  describe("check_file/1") do
    test "when the file type is a .csv, read the file and returns a map." do
      param = %Plug.Upload{
        path: "c:/Users/willi/AppData/Local/Temp/plug-1669/multipart-1669845794-311717596435-4",
        content_type: "application/pdf",
        filename: "partners.csv"
      }

      response = Csv.check_file(param)

      expected_response = "banana"
      #   #Stream<[
      #   enum: #Function<61.124013645/2 in Stream.transform/4>,
      #   funs: [#Function<48.124013645/1 in Stream.map/2>]
      #   ]>

      assert response == expected_response
    end

    test "when the file type is not a .csv, the fallback controller returns an error." do
      param = %Plug.Upload{
        path: "c:/Users/willi/AppData/Local/Temp/plug-1669/multipart-1669845794-311717596435-4",
        content_type: "application/pdf",
        filename: "Curriculo.pdf"
      }

      response = Csv.check_file(param)

      expected_response = "banana"
      #   #Stream<[
      #   enum: #Function<61.124013645/2 in Stream.transform/4>,
      #   funs: [#Function<48.124013645/1 in Stream.map/2>]
      #   ]>

      assert response == expected_response
    end
  end
end
