-module(emqx_td_ready_handler).

-export([init/2]).

-define(SIGNAL_HANDLER, signal_handler).

init(Req, State) ->
    try ?SIGNAL_HANDLER:rcvd(sigterm) of
        true ->
            Resp = cowboy_req:reply(502,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    <<"Terminating.">>,
                                    Req),
            {ok, Resp, State};
        false ->
            Resp = cowboy_req:reply(200,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    <<"Ready.">>,
                                    Req),
            {ok, Resp, State}

    catch
        _ ->
            io:format("Ready endpoint probed but the plugin hasn't been loaded yet."),
            Resp = cowboy_req:reply(502,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    <<"Not ready.">>,
                                    Req),
            {ok, Resp, State}
    end.

