module Page.About exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    section []
        [ h1 [] [ text "About" ]
        , h2 [] [ text "Introduction" ]
        , p []
            [ text
                """
                Beyoncé Giselle Knowles-Carter (/biːˈjɒnseɪ/; born September 4, 1981) is an American singer, songwriter, dancer, and actress. Born and raised in Houston, Texas, Beyoncé performed in various singing and dancing competitions as a child. She rose to fame in the late 1990s as lead singer of the R&B girl-group Destiny's Child. Managed by her father, Mathew Knowles, the group became one of the world's best-selling girl groups in history. Their hiatus saw Beyoncé's theatrical film debut in Austin Powers in Goldmember (2002) and the release of her debut album, Dangerously in Love (2003). The album established her as a solo artist worldwide, earned five Grammy Awards, and featured the Billboard Hot 100 number-one singles "Crazy in Love" and "Baby Boy".
                """
            ]
        , h2 [] [ text "Early Life" ]
        , p []
            [ text
                """
Beyoncé Giselle Knowles was born in Houston, Texas, to Celestine "Tina" Knowles (née Beyincé), a hairdresser and salon owner, and Mathew Knowles, a Xerox sales manager. Beyoncé's name is a tribute to her mother's maiden name. Beyoncé's younger sister Solange is also a singer and a former back up dancer for Destiny's Child. Solange and Beyoncé are the first sisters to have both had No. 1 albums.[26] Mathew is African American, while Tina is of Louisiana Creole descent (African, Native American, and French). Through her mother, Beyoncé is a descendant of Acadian leader Joseph Broussard.
            """
            ]
        , h2 [] [ text "Influences" ]
        , p []
            [ text
                """
Jody Rosen highlights her tone and timbre as particularly distinctive, describing her voice as "one of the most compelling instruments in popular music". Her vocal abilities mean she is identified as the centerpiece of Destiny's Child. Jon Pareles of The New York Times commented that her voice is "velvety yet tart, with an insistent flutter and reserves of soul belting". Rosen notes that the hip hop era highly influenced Beyoncé's unique rhythmic vocal style, but also finds her quite traditionalist in her use of balladry, gospel and falsetto. Other critics praise her range and power, with Chris Richards of The Washington Post saying she was "capable of punctuating any beat with goose-bump-inducing whispers or full-bore diva-roars."
            """
            ]
        , small [] [ text "Source: Wikipedia" ]
        ]
