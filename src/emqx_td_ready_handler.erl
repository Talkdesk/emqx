-module(emqx_td_ready_handler).

-export([init/2]).

init(Req, State) ->
    io:format("Got health check request"),
    Resp = cowboy_req:reply(200,
             #{<<"content-type">> => <<"text/plain">>},
             <<"Ready.">>,
             Req),
    {ok, Resp, State}.
