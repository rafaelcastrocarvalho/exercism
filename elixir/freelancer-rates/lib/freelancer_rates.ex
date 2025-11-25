defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * daily_work_ours()

  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100
  end

  def monthly_rate(hourly_rate, discount) do
    daily_rate = discounted_daily_rate(hourly_rate, discount)
    monthly_rate = daily_rate * monthly_billable_days()
    ceil(monthly_rate)
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate = discounted_daily_rate(hourly_rate, discount)
    days_in_budget = budget / daily_rate
    Float.floor(days_in_budget, 1)
  end

  defp daily_work_ours, do: 8.0
  
  defp monthly_billable_days, do: 22

  defp discounted_daily_rate(hourly_rate, discount) do
    hourly_rate 
    |> daily_rate() 
    |> apply_discount(discount)
  end
end
