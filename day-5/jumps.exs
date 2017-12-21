defmodule Jump do
  def get_steps(file) do
    File.stream!(file)
    |> Enum.map(&(String.trim(&1, "\n") |> String.to_integer()))
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {jump, i}, jumps ->
      Map.put(jumps, i, jump)
    end)
  end

  def steps([]), do: 0
  def steps(list, alter_step_length) do
    step(list, alter_step_length, 0, 0)
  end

  defp step(list, _, index, step_count) when index + 1 > map_size(list) do
    step_count
  end
  defp step(list, alter_step_length, index, step_count) do
    step_length = list[index]

    list
    |> Map.put(index, alter_step_length.(list[index]))
    |> step(alter_step_length, index + step_length, step_count + 1)
  end

  def alter_length_simple(step_length), do: step_length + 1

  def alter_length_complex(step_length) when step_length > 2, do: step_length - 1
  def alter_length_complex(step_length), do: step_length + 1
end

# Test Part 1
# Jump.steps([0, 3, 0, 1, -3], &Jump.alter_length_simple/1) |> IO.puts() # 5

# Test Part 2
# Jump.steps([0, 3, 0, 1, -3], &Jump.alter_length_complex/1) |> IO.puts() # 5

Jump.get_steps('input') |> Jump.steps(&Jump.alter_length_complex/1) |> IO.puts()
