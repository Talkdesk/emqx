-module(emqx_td_probe_handler).

-export([init/2]).

init(Req, State) ->
    Payload = case cowboy_req:path(Req) of
                  "/ready" -> <<"Ready.">>;
                  "/live" -> <<"Live.">>
              end,
    Resp = cowboy_req:reply(200,
                            #{<<"content-type">> => <<"text/plain">>},
                            Payload,
                            Req),
    {ok, Resp, State}.
