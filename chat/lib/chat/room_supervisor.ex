defmodule Chat.RoomSupervisor do
  use Supervisor

  def start_room(room_name) do
    Supervisor.start_child(:room_supervisor, [room_name])
  end


  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, [name: :room_supervisor])
  end

  def init(:ok) do
    children = [worker(Chat.Room, [], [restart: :temporary])]
    supervise(children, strategy: :simple_one_for_one)
  end
end
