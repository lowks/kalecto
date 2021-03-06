defmodule Kalecto.Date do
  require Kalends.Date
  import Ecto.DateTime.Util

  @moduledoc """
  Kalends Date for Ecto
  """

  @behaviour Ecto.Type

  @doc """
  The Ecto primitive type.
  """
  def type, do: :date

  @doc """
  Dates are blank when given as strings and the string is blank.
  """
  defdelegate blank?(value), to: Ecto.Type

  @doc """
  Casts to date.
  """
  def cast(<<year::32, ?-, month::16, ?-, day::16>>),
    do: from_parts(to_i(year), to_i(month), to_i(day))
  def cast(%Kalends.Date{} = d),
    do: {:ok, d}
  def cast(_),
    do: :error

  defp from_parts(year, month, day) when is_date(year, month, day) do
    Kalends.Date.from_erl({year, month, day})
  end

  defp from_parts(_, _, _), do: :error

  @doc """
  Converts to erlang style triplet
  """
  def dump(%Kalends.Date{} = date) do
    {:ok, Kalends.Date.to_erl(date)}
  end

  @doc """
  Converts erlang style triplet to `Kalends.Date`
  """
  def load({year, month, day}) do
    Kalends.Date.from_erl({year, month, day})
  end
end
