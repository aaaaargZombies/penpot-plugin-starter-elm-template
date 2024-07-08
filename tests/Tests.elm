module Tests exposing (..)

import Expect
import Fuzz exposing (Fuzzer)
import Test exposing (Test)


stringFuzzer : Fuzzer String
stringFuzzer =
    Fuzz.intRange (Char.toCode 'a') (Char.toCode 'z')
        |> Fuzz.map Char.fromCode
        |> Fuzz.list
        |> Fuzz.map String.fromList


suite : Test
suite =
    Test.describe "Some example tests"
        [ Test.test "the empty list has 0 length" <|
            \_ ->
                List.length []
                    |> Expect.equal 0
        , Test.fuzz stringFuzzer "reversing a string twice should be equal to not reversing the string" <|
            \str ->
                str
                    |> String.reverse
                    |> String.reverse
                    |> Expect.equal str
        ]
