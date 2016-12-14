defmodule Chat.Room do
  use GenServer

  def publish(room_name, message) do
    GenServer.cast(via_tuple(room_name), {:publish, message})
  end

  def join_room(room_name, _user_name) do
    Registry.register(Chat.Room.Members, room_name, nil)
  end

  defp via_tuple(room_name) do
    {:via, Registry, {Chat.Room.Topic, room_name}}
  end


  def start_link(room_name) do
    GenServer.start_link(__MODULE__, room_name, [name: via_tuple(room_name)])
  end

  def init(room_name) do
    {:ok, %{room_name: room_name}}
  end

  def handle_cast({:publish, message}, %{room_name: room_name} = state) do
    Registry.dispatch(Chat.Room.Members, room_name, fn members ->
      for {pid, nil} <- members, do: send(pid, {:broadcast, message})
    end)
    {:noreply, state}
  end
  def handle_cast(any, state) do
    IO.puts(any)
    {:noreply, state}
  end
end
