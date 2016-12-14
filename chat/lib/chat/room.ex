defmodule Chat.Room do
  use GenServer

  def publish(room_name, message) do
    Registry.dispatch(Chat.Room.Proc, room_name, fn entries ->
      for {pid, nil} <- entries, do: send(pid, {:broadcast, message})
    end)
  end

   def join_room(room_name, _user_name) do
     Registry.register(Chat.Room.Proc, room_name, nil)
   end

   defp via_tuple(room_name) do
     {:via, Registry, {Chat.Room.Proc, room_name}}
   end


  def start_link(room_name) do
    GenServer.start_link(__MODULE__, :ok, [name: via_tuple(room_name)])
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:publish, message}, pids) do
    IO.inspect(message)
    IO.inspect(pids)
    for pid <- pids, do: send(pid, {:broadcast, message})
    IO.puts("AAAAAAAAAA")
    {:noreply, pids}
  end
  def handle_cast(any, messages) do
    IO.puts(any)
    {:noreply, messages}
  end
end
