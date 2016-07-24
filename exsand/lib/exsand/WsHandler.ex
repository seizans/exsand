defmodule Exsand.WsHandler do
  @behaviour :cowboy_websocket

  require Record
  Record.defrecordp :state, count: 0
  @type state :: record(:state, count: non_neg_integer)

  def init(req, _opts) do
    IO.puts "wshandler init"
    {:cowboy_websocket, req, state(count: 10)}
  end

  def websocket_handle({:text, "count"}, req, state(count: count)) do
    IO.puts "wshandler handle 1"
    count_bin = Integer.to_string(count)
    {:reply, {:text, count_bin}, req, state(count: count + 1)}
  end
  def websocket_handle({:text, "reset_count"}, req, _state) do
    IO.puts "wshandler handle 2"
    {:reply, {:text, "0"}, req, state(count: 0)}
  end
  def websocket_handle(_in_frame, req, _state) do
    IO.puts "wshandler handle 3"
    {:stop, req, state}
  end

  def websocket_info(_out_frame, req, state) do
    IO.puts "wshandler info"
    {:stop, req, state}
  end
end
