defmodule ExFtx.OrderConditional do
  alias __MODULE__

  @type id :: pos_integer
  @type t :: %OrderConditional{
          created_at: String.t(),
          future: String.t(),
          id: id,
          market: ExFtx.Market.name(),
          trigger_price: number,
          side: String.t(),
          size: number,
          status: String.t(),
          type: String.t(),
          order_price: number,
          triggered_at: String.t(),
          reduce_only: boolean,
          order_type: String.t(),
          retry_until_filled: boolean
        }

  defstruct ~w[
    created_at
    future
    id
    market
    trigger_price
    side
    size
    status
    type
    order_price
    triggered_at
    reduce_only
    order_type
    retry_until_filled
  ]a
end
