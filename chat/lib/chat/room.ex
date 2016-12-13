defmodule Chat.Room do
  use GenServer

  def publish(room_name, message) do
    IO.puts("BBBBBBBBBBBB")
    GenServer.cast(via_tuple(room_name), {:publish, message})
  end

  def join_room(room_name, _user_name, pid) do
    GenServer.cast(via_tuple(room_name), {:join_room, pid})
  end

  def add_message(room_name, message) do
    GenServer.cast(via_tuple(room_name), {:add_message, message})
  end

  def get_messages(room_name) do
    GenServer.call(via_tuple(room_name), :get_messages)
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

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end

  def handle_cast({:join_room, pid}, pids) do
    {:noreply, [pid | pids]}
  end
  def handle_cast({:publish, message}, pids) do
    IO.inspect(message)
    IO.inspect(pids)
    for pid <- pids, do: send(pid, {:broadcast, message})
    IO.puts("AAAAAAAAAA")
    {:noreply, pids}
  end
  def handle_cast({:add_message, message}, messages) do
    {:noreply, [message | messages]}
  end
end
