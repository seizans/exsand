defmodule Chat.WsHandler do
  @behaviour :cowboy_websocket

  def init(req, _opts) do
    IO.puts "WebSocket connected"
    {:cowboy_websocket, req, %{room_name: nil, player_id: nil}}
  end

  def websocket_handle({:text, body}, req, state) do
    case Poison.decode(body) do
      {:ok, json} ->
        IO.inspect(json)
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
    case Chat.RoomSupervisor.start_room(room_name) do
      {:ok, _pid} ->
        {:reply, {:text, "#{room_name} CREATED"}, req, state}
      {:error, {:already_started, _pid}} ->
        {:reply, {:text, "#{room_name} IS ALREADY CREATED"}, req, state}
    end
  end
  defp handle(%{"player_id" => player_id, "room_name" => room_name}, req, state) do
    {:ok, _pid} = Chat.Room.join_room(room_name, player_id)
    {:reply, {:text, "Hello #{player_id}"}, req, %{state | player_id: player_id, room_name: room_name}}
  end
  defp handle(%{"comment" => comment}, req, %{room_name: room_name, player_id: _player_id} = state) do
    Chat.Room.publish(room_name, comment)
    {:ok, req, state}
  end

  def websocket_info({:broadcast, message}, req, state) do
    IO.inspect(message)
    {:reply, {:text, message}, req, state}
  end
  def websocket_info(out_frame, req, state) do
    IO.inspect(out_frame)
    {:stop, req, state}
  end
end
