defmodule NameBadge do
  def print(id, name, department) do
    format_id(id) <> format_name(name) <> format_department(department)
  end

  defp format_id(id) do
    if id, do: "[#{id}] - ", else: ""
  end

  defp format_name(name) do
    name <> " - "
  end

  defp format_department(department) do
    if department, do: String.upcase(department), else: "OWNER"
  end
end
