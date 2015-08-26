# Description:
#   Let hubot google that for you
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lmgtfy <terms>
#
# Author:
#   Shaun Donnelly <https://github.com/shaundon>

module.exports = (robot) ->

  robot.respond /lmgtfy (.*)/i, (msg) ->
    terms = msg.match[1]
    msg.send "http://lmgtfy.com/?q=" + encodeURIComponent(terms)

