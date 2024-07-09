port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Json.Encode


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Flags =
    ()


type alias Model =
    { count : Int }


type Msg
    = Increment
    | Decrement
    | ExternalMsg MsgFromPlugin
    | NoOp


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { count = 0 }
    , sendMessage Ready
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch [ fromPlugin portDecoder ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }
            , sendMessage Change
            )

        Decrement ->
            ( { model | count = model.count - 1 }
            , sendMessage Change
            )

        ExternalMsg extMsg ->
            case extMsg of
                Status ->
                    ( model
                    , sendMessage (State model.count)
                    )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Decrement ] [ text "-1" ]
        ]


type MsgToPlugin
    = Ready
    | Change
    | State Int


toValue : MsgToPlugin -> Json.Encode.Value
toValue msg =
    case msg of
        Ready ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "Ready" )
                ]

        Change ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "Change" )
                ]

        State n ->
            Json.Encode.object
                [ ( "kind", Json.Encode.string "State" )
                , ( "content", Json.Encode.int n )
                ]


sendMessage : MsgToPlugin -> Cmd msg
sendMessage =
    toValue >> toPlugin


port toPlugin : Json.Encode.Value -> Cmd msg


type MsgFromPlugin
    = Status


statusDecoder : Json.Decode.Decoder MsgFromPlugin
statusDecoder =
    Json.Decode.field "kind" Json.Decode.string
        |> Json.Decode.andThen
            (\str ->
                if str == "Status" then
                    Json.Decode.succeed Status

                else
                    Json.Decode.fail "Not Status"
            )


portDecoder : Json.Decode.Value -> Msg
portDecoder json =
    Json.Decode.decodeValue (Json.Decode.oneOf [ statusDecoder ]) json
        |> Result.map (\msg -> ExternalMsg msg)
        |> Result.withDefault NoOp


port fromPlugin : (Json.Decode.Value -> msg) -> Sub msg
