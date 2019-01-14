-module(emqx_td_live_handler).

-export([init/2]).

init(Req, State) ->
    Resp = cowboy_req:reply(200,
                            #{<<"content-type">> => <<"text/plain">>},
                            <<"Live.">>,
                            Req),
    {ok, Resp, State}.
