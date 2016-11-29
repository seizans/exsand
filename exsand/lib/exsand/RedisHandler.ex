defmodule Exsand.RedisHandler do
  @behaviour :cowboy_handler

  def init(req, _opt) do
    id = :cowboy_req.binding :id, req
    case :cowboy_req.method req do
      "GET" ->
        case Exsand.Redis.get id do
          :not_found ->
            req2 = :cowboy_req.reply 404, req
            {:ok, req2, nil}
          name ->
            body = Poison.encode!(%{name: name})
            req2 = :cowboy_req.reply 200, [], body, req
            {:ok, req2, nil}
        end
      "POST" ->
        {:ok, body, req2} = :cowboy_req.body(req)
        %{"name" => name} = Poison.decode!(body)
        IO.inspect name
        :ok = Exsand.Redis.set id, name
        req3 = :cowboy_req.reply 200, req2
        {:ok, req3, nil}
      other ->
        req2 = :cowboy_req.reply 405, req
        {:ok, req2, nil}
    end
  end

end
