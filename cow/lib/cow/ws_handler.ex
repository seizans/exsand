defmodule Cow.WsHandler do
  @behaviour :cowboy_websocket

  def init(req, _opts) do
    {:cowboy_websocket, req, %{count: 0}}
  end

  def websocket_handle({:text, "inc"}, req, %{count: count} = state) do
    new_count = count + 1
    IO.puts "Now the count is increased to #{new_count}"
    {:reply,
     {:text, Integer.to_string(new_count)},
     req,
     %{state | count: new_count}}
  end
  def websocket_handle({:text, "reset_count"}, req, state) do
    IO.puts "Count is reset to 0"
    {:reply, {:text, "0"}, req, %{state | count: 0}}
  end
  def websocket_handle(_in_frame, req, state) do
    IO.puts("Only 'inc' or 'reset_count' can be accepted.")
    {:stop, req, state}
  end

  # TODO(seizans): タイマーでメッセージパッシングして stop するサンプル置いておく
  def websocket_info(out_frame, req, state) do
    IO.inspect(out_frame)
    {:stop, req, state}
  end

end
