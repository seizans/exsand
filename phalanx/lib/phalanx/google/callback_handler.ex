defmodule Phalanx.Google.CallbackHandler do
  @behaviour :cowboy_handler
  require Logger

  # TODO(seizans): config へ出す
  @client_id "480969685993-nv7t5lt0i1cm24d4k4e74j7iar2qjqfm.apps.googleusercontent.com"
  @client_secret "PUT YOUR SECRET"
  @redirect_uri "http://localhost:8080/google/callback"

  @token_endpoint %URI{scheme: "https",
                       host: "accounts.google.com",
                       path: "/o/oauth2/token"}

  def init(req, [] = _opts) do
    case :cowboy_req.match_qs([{:code, :nonempty, nil}, {:state, :nonempty, nil}, {:error, :nonempty, nil}], req) do
      %{code: code, state: state, error: nil} ->
        IO.puts("success")
        IO.inspect(code)
        IO.inspect(state)
        case get_token(code) do
          {:ok, resp_body} ->
            IO.inspect(resp_body)
            req = :cowboy_req.reply(200, req)
            {:ok, req, nil}
          {:error, reason} ->
            Logger.warn("FAILED TO GET TOKEN | reason=#{reason}")
            req = :cowboy_req.reply(400, req)
            {:ok, req, nil}
        end
      %{code: nil, state: state, error: error} ->
        IO.puts("error")
        IO.inspect(error)
        IO.inspect(state)
        req = :cowboy_req.reply(400, req)
        {:ok, req, nil}
    end
  end

  defp get_token(code) do
    req_body = %{code: code,
                 client_id: @client_id,
                 client_secret: @client_secret,
                 redirect_uri: @redirect_uri,
                 grant_type: "authorization_code"}
               |> URI.encode_query()
    req_headers = %{"content-type" => "application/x-www-form-urlencoded"}
    case HTTPoison.post(@token_endpoint, req_body, req_headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_response(body)}
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, response}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_response(body) do
    # TODO(seizans): id_token を検証する
    %{"access_token" => access_token,
      "expires_in" => 3600,
      "id_token" => id_token,
      "token_type" => "Bearer"} = Poison.decode!(body)
  end
end
