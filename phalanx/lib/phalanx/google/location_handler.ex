defmodule Phalanx.Google.LocationHandler do
  @behaviour :cowboy_handler
  require Logger

  # TODO(seizans): config へ出す
  @client_id "480969685993-nv7t5lt0i1cm24d4k4e74j7iar2qjqfm.apps.googleusercontent.com"
  @redirect_uri "http://localhost:8080/google/callback"

  @auth_endpoint %URI{scheme: "https",
                      host: "accounts.google.com",
                      path: "/o/oauth2/auth"}

  def init(req, [] = _opts) do
    query = %{client_id: @client_id,
              scope: "openid",
              response_type: "code",
              redirect_uri: @redirect_uri}
            |> URI.encode_query()
    uri = %URI{@auth_endpoint | query: query}
    Logger.info(URI.to_string(uri))
    headers = %{"location" => URI.to_string(uri)}
    req = :cowboy_req.reply(302, headers, req)
    {:ok, req, nil}
  end
end
