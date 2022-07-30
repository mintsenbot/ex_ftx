defmodule ExFtx.Orders.CancelConditionalByOrderId do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type result :: :ok | {:error, String.t() | :unhandled_result}

  @spec delete(credentials, ExFtx.OrderConditional.id()) :: result
  def delete(credentials, order_id) do
    "/conditional_orders/#{order_id}"
    |> ExFtx.HTTPClient.auth_delete(credentials)
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: result}}) do
    result
    |> case do
      "Order cancelled" -> :ok
      _ -> {:error, :unhandled_result}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
