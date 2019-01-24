-module(emqx_td_ready_handler).

-export([init/2]).

-define(SIGNAL_HANDLER, signal_handler).

init(Req, State) ->
    case emqx_plugins:loaded(?SIGNAL_HANDLER) of
        true ->
            case ?SIGNAL_HANDLER:rcvd(sigterm) of
                true ->
                    Resp = cowboy_req:reply(503,
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
            end;
        false ->
            Resp = cowboy_req:reply(503,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    <<"Not ready yet.">>,
                                    Req),
            {ok, Resp, State}
    end.

