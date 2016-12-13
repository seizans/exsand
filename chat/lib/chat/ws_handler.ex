defmodule Chat.WsHandler do
  @behaviour :cowboy_websocket

  def init(req, _opts) do
    IO.puts "WebSocket connected"
    {:cowboy_websocket, req, %{}}
  end

  def websocket_handle({:text, "player_id: " <> player_id}, req, state) do
    # TODO(seizans): 本当はこのユーザー処理は connect 時にやるべき
    IO.puts player_id
    # TODO(seizans): Room に登録する
    {:reply, {:text, "Hello #{player_id}"}, req, state}
  end
  def websocket_handle({:text, "comment: " <> comment}, req, state) do
    IO.puts comment
    {:reply, {:text, "#{comment} ACCEPTED"}, req, state}
  end
  def websocket_handle(in_frame, req, state) do
    IO.puts("Invalid format")
    IO.inspect(in_frame)
    {:stop, req, state}
  end

  def websocket_info(out_frame, req, state) do
    IO.inspect(out_frame)
    {:stop, req, state}
  end
end
