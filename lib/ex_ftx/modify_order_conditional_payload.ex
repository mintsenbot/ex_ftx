defmodule ExFtx.ModifyOrderConditionalPayload do
  alias __MODULE__

  @type t :: %ModifyOrderConditionalPayload{
          size: number | nil,
          trigger_price: number | nil,
          order_price: number | nil,
          trail_value: number | nil
        }

  defstruct ~w[
    size
    trigger_price
    order_price
    trail_value
  ]a
end
