#!/bin/bash
#
# Environment variables:
#
#   GLM_PRELOAD     GLM file to load before gridlabd.glm
#   GLM_TIMEZONE    timezone
#   GLM_STARTTIME   start time
#   GLM_STOPTIME    stop time
#   GLM_WEATHER     TMY3 weather file
#   GLM_POSTLOAD    GLM file to load after gridlabd.glm
#   GLM_TEMPLATE    template to use
#

# HACK: temporary fix for missing requirement for module in tmy32glm converter
python3 -m networkx >/dev/null || touch networkx.py

[ -f gridlabd.pre ] && source gridlabd.pre
[ ! -z "$GLM_TEMPLATE" ] && gridlabd template get $GLM_TEMPLATE
[ ! -z "$GLM_WEATHER" ] && gridlabd weather get $GLM_WEATHER
if [ ! -z "$GLM_TIMEZONE" -o ! -z "$GLM_STARTTIME" -o -z "$GLM_STOPTIME" ]; then
         echo "clock {
        ${GLM_TIMEZONE:+timezone \"$GLM_TIMEZONE\";}
        ${GLM_STARTTIME:+starttime \"$GLM_STARTTIME\";}
        ${GLM_STOPTIME:+stoptime \"$GLM_STOPTIME\";}
}
" > clock.glm
    GLM_CLOCK=clock.glm
fi

echo "Running $(gridlabd --version=all)"
if gridlabd --redirect all ${GLM_PRELOAD} gridlabd.glm ${GLM_CLOCK} ${GLM_WEATHER} ${GLM_POSTLOAD} ${GLM_TEMPLATE:+-t "$GLM_TEMPLATE"} ; then
    EXITCODE=0
    [ -f gridlabd.post ] && source gridlabd.post 
else
    EXITCODE=$?
    cat gridlabd.err >/dev/stderr
fi

# remove empty output files
find . -size 0 -name gridlabd.\* -type f -exec rm \{\} \;

# HACK: remove temporary fix for tmy32glm converter
[ -s networkx.py ] || rm networkx.py

exit $EXITCODE
