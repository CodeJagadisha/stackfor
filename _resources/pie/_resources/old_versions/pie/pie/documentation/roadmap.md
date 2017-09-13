[[]] or []
"$" everywhere

Delete temp on exit
More colbols?

Add descriptions to "pie help"

List
    A*
    languages
    ides
    apps

Haxe - silent setup

piengine - ignoring pie.sh and piengine.sh





# Display a nicely formatted error message with detailed information.
function ErrorMsg()
{
    printf "
%2s ${tB}PIE ERROR!${tO}
%2s      FILE:\t$1
%2s  FUNCTION:\t$2
%2s      LINE:\t$3
%2sDESCRIPTION:\t$4\n\n"
}