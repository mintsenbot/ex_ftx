defmodule ExFtx.Orders.ModifyConditionalByOrderId do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type modify_order_payload :: ExFtx.ModifyOrderConditionalPayload.t()
  @type order :: ExFtx.OrderConditional.t()
  @type result :: {:ok, order} | {:error, String.t() | :parse_result_item}

  @spec post(credentials, ExFtx.OrderConditional.id(), modify_order_payload) :: result
  def post(credentials, order_id, modify_order_payload) do
    "/conditional_orders/#{order_id}/modify"
    |> ExFtx.HTTPClient.auth_post(credentials, to_payload(modify_order_payload))
    |> parse_response()
  end

  defp to_payload(modify_order_payload) do
    modify_order_payload
    |> Map.from_struct()
    |> ProperCase.to_camel_case()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: order}}) do
    order
    |> Mapail.map_to_struct(ExFtx.Order, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
