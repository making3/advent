defmodule Jump do
  def get_steps(file) do
    File.stream!(file)
    |> Stream.map(&(String.trim(&1, "\n") |> String.to_integer()))
    |> Enum.to_list()
  end

  def steps([]), do: 0
  def steps(list) do
    step(list, 0, 0)
  end

  defp step(list, index, step_count) when index + 1 > length(list) do
    step_count
  end
  defp step(list, index, step_count) do
    step_length = Enum.fetch!(list, index)

    list
    |> List.replace_at(index, step_length + 1)
    |> step(index + step_length, step_count + 1)
  end
end

# Test
# Jump.steps([0, 3, 0, 1, -3]) |> IO.puts() # 5

Jump.get_steps('input') |> Jump.steps() |> IO.puts()
