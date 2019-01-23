-module(emqx_td_ready_handler).

-export([init/2]).

-define(SIGNAL_HANDLER, signal_handler).

init(Req, State) ->
    {Code, Body} = case ?SIGNAL_HANDLER:rcvd(sigterm) of
        true -> {502, <<"Terminating.">>};
        false -> {200, <<"Ready.">>}
    end,
    Resp = cowboy_req:reply(Code,
                            #{<<"content-type">> => <<"text/plain">>},
                            Body,
                            Req),
    {ok, Resp, State}.
