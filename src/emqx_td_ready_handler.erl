-module(emqx_td_ready_handler).

-export([init/2]).

init(Req, State) ->
    {Code, Body} = case emqx_signal_handler:rcvd(sigterm) of
        true -> {502, <<"Terminating.">>};
        false -> {200, <<"Ready.">>}
    end,
    Resp = cowboy_req:reply(Code
                            #{<<"content-type">> => <<"text/plain">>},
                            Body,
                            Req),
    {ok, Resp, State}.
