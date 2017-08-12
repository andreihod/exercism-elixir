defmodule SecretHandshake do
  use Bitwise

  @commands %{1 => ["wink"], 2 => ["double blink"], 4 => ["close your eyes"], 8 => ["jump"]}

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    handshake = []
    |> check_code(code, 1)
    |> check_code(code, 2)
    |> check_code(code, 4)
    |> check_code(code, 8)
    |> check_reverse(code)
  end

  defp check_code(handshake, code, command) do
    if (code &&& command) > 0 ,
      do: handshake ++ Map.get(@commands, command),
    else: handshake
  end

  defp check_reverse(handshake, code) do
    if (code &&& 16) > 0 ,
      do: Enum.reverse(handshake),
    else: handshake
  end

end
