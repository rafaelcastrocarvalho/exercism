defmodule LibraryFees do
  @monday 1

  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime) do
    noon = %{datetime | hour: 12, minute: 00, second: 00}
    NaiveDateTime.compare(datetime, noon) == :lt
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> calculate_days_to_add()
    |> add_days(checkout_datetime)
  end

  defp calculate_days_to_add(datetime), do: if(before_noon?(datetime), do: 28, else: 29)

  defp add_days(days_to_add, date), do: Date.add(date, days_to_add)

  def days_late(planned_return_date, actual_return_date) do
    Date.diff(actual_return_date, planned_return_date) |> max(0)
  end

  def monday?(datetime), do: Date.day_of_week(datetime) == @monday

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return_datetime)
    |> Kernel.*(rate)
    |> apply_monday_discount_when_suitable(return_datetime)
  end

  defp apply_monday_discount_when_suitable(late_fee, return_datetime) do
    if monday?(return_datetime), do: Integer.floor_div(late_fee, 2), else: late_fee
  end
end
