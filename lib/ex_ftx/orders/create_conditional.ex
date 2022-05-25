defmodule ExFtx.Orders.CreateConditional do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type order_payload :: ExFtx.OrderConditionalPayload.t()
  @type order :: ExFtx.OrderConditional.t()
  @type result :: {:ok, order} | {:error, String.t() | :parse_result_item}

  @spec post(credentials, order_payload) :: result
  def post(credentials, order_payload) do
    "/conditional_orders"
    |> ExFtx.HTTPClient.auth_post(credentials, to_payload(order_payload))
    |> parse_response()
  end

  defp to_payload(order_payload) do
    order_payload
    |> Map.from_struct()
    |> ProperCase.to_camel_case()
    |> IO.inspect()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: order}}) do
    order
    |> Mapail.map_to_struct(ExFtx.OrderConditional, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
