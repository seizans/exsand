defmodule Chat.RoomHandler do
  @behaviour :cowboy_handler

  def init(req, _opts) do
    case :cowboy_req.method(req) do
      "POST" ->
        headers = [{"content-type", "application/json"}]
        {:ok, req_body, req2} = :cowboy_req.body(req)
        # TODO(seizans): 本当は decode で場合分けする
        case Poison.decode!(req_body) do
          %{"room_name" => room_name} ->
            {:ok, _pid} = Chat.RoomSupervisor.start_room(room_name)
            body = %{}
                   |> Poison.encode!()
            req3 = :cowboy_req.reply(200, headers, body, req2)
            {:ok, req3, nil}
          _ ->
            req2 = :cowboy_req.reply(405, req)
            {:ok, req2, nil}
        end
      _ ->
        req2 = :cowboy_req.reply(405, req)
        {:ok, req2, nil}
    end
  end

end
