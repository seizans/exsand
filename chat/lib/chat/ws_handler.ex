defmodule Chat.WsHandler do
  @behaviour :cowboy_websocket

  def init(req, _opts) do
    IO.puts "WebSocket connected"
    {:cowboy_websocket, req, %{}}
  end

  def websocket_handle({:text, body}, req, state) do
    case Poison.decode(body) do
      {:ok, json} ->
        handle(json, req, state)
      {:error, reason} ->
        IO.inspect(reason)
    end
  end
  def websocket_handle(in_frame, req, state) do
    IO.puts("Invalid format")
    IO.inspect(in_frame)
    {:stop, req, state}
  end

  defp handle(%{"room_name" => room_name}, req, state) do
    IO.puts("Room name: #{room_name}")
    {:ok, _pid} = Chat.RoomSupervisor.start_room(room_name)
    {:reply, {:text, "#{room_name} CREATED"}, req, state}
  end
  defp handle(%{"player_id" => player_id}, req, state) do
    # TODO(seizans): 本当はこのユーザー処理は connect 時にやるべき
    IO.puts player_id
    # TODO(seizans): Room に登録する
    {:reply, {:text, "Hello #{player_id}"}, req, state}
  end
  defp handle(%{"comment" => comment}, req, state) do
    IO.puts comment
    {:reply, {:text, "#{comment} ACCEPTED"}, req, state}
  end

  def websocket_info(out_frame, req, state) do
    IO.inspect(out_frame)
    {:stop, req, state}
  end
end
