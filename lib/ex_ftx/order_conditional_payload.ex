defmodule ExFtx.OrderConditionalPayload do
  alias __MODULE__

  @type t :: %OrderConditionalPayload{
          market: ExFtx.Market.name(),
          side: String.t(),
          size: number,
          type: String.t(),
          reduce_only: boolean,
          retry_until_filled: boolean,
          trigger_price: number,
          order_price: number,
          trail_value: number
        }

  defstruct ~w[
    market
    side
    size
    type
    reduce_only
    retry_until_filled
    trigger_price
    order_price
    trail_value
  ]a
end
